class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   has_one_attached :profile_image
   has_many :post_comments, dependent: :destroy
   has_many :postings, dependent: :destroy
   has_many :favorites, dependent: :destroy

   # フォローをした、されたの関係
   has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
   has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

   # 一覧画面で使う
   has_many :followings, through: :relationships, source: :followed
   has_many :followers, through: :reverse_of_relationships, source: :follower

   has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
   has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

# Rails.logger.debug "File Path: #{file_path}"
  # def get_profile_image(width,height)
  #   unless profile_image.attached?
  #     file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
  #     profile_image.attach(io: File.open(file_path), filename: 'sample-author1.jpg', content_type: 'image/jpeg')
  #   end
  #   profile_image.variant(resize_to_limit: [width, height]).processed
  # end

  # def get_profile_image(width,height)
  #   unless profile_image.attached?
  #     file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
  #   #binding.pry
  #     profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  #   end
  #   profile_image.variant(resize_to_limit: [width, height]).processed
  # end





  # def get_profile_image(width, height)
  # if profile_image.attached?
  #   profile_image.variant(resize_to_limit: [width, height]).processed
  # else
  #   # デフォルトの画像のパスを指定して返す
  #   default_image_path = Rails.root.join('app/assets/images/sample-author1.jpg')
  #   image_tag default_image_path, class: "rounded-circle"
  # end
  # end


  # def get_profile_image(width, height)
  #   if profile_image.attached?
  #     profile_image.variant(resize_to_limit: [width, height]).processed
  #   else
  #     ActionController::Base.helpers.image_tag('sample-author1.jpg', class: 'rounded-circle')
  #   end
  # end

  # def get_profile_image(width, height)
  #   Rails.logger.info "Profile image attached: #{profile_image.attached?}"
  #   if profile_image.attached?
  #     profile_image.variant(resize_to_limit: [width, height]).processed
  #   else
  #     'sample-author1.jpg'
  #   end
  # end



  # def get_profile_image(width, height)
  # if profile_image.attached?
  #   begin
  #     profile_image.variant(resize_to_limit: [width, height]).processed
  #   rescue ActiveStorage::FileNotFoundError => e
  #     # エラーログを出力するなどの適切なエラーハンドリング処理を行います
  #     Rails.logger.error("Error: #{e.message}")
  #     # 代替の処理を行う場合は、デフォルトの画像を表示するなどの処理を追加します
  #     default_image_path = Rails.root.join('app/assets/images/sample-author1.jpg')
  #     image_tag default_image_path, class: "rounded-circle"
  #   end
  # else
  #   default_image_path = Rails.root.join('app/assets/images/sample-author1.jpg')
  #   image_tag default_image_path, class: "rounded-circle"
  # end
  # end














  def active_for_authentication?
   super && (is_deleted == false)
  end

  # フォローしたときの処理
  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end
  # フォローを外すときの処理
  def unfollow(customer_id)
     relationships.find_by(followed_id: customer_id).destroy
  end
  # フォローしているか判定
  def following?(customer)
    followings.include?(customer)
  end

  def create_notification_follow!(current_customer)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_customer.id, id, 'follow'])
    if temp.blank?
      notification = current_customer.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def self.search(search) #self.はUser.を意味する
   if search
     where(['username LIKE ?', "%#{search}%"]) #検索とuseanameの部分一致を表示。
   else
     all #全て表示させる
   end
  end

end
