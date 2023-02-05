class Posting < ApplicationRecord

  has_one_attached :profile_image
  validates :body, presence: true
  validates :profile_image, presence: true
  belongs_to :customer

  def get_profile_image(width,height)
     unless profile_image.attached?
       file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
       profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
     end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end


end
