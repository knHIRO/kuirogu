class Public::HomesController < ApplicationController
  def top
    @postings = Posting.all.order(id: "DESC")
  end

  def guest_sign_in
    customer = Customer.find_or_create_by!(email: 'guest@example.com') do |customer|
    customer.first_name = 'Guest'
    customer.last_name = 'User'
    customer.last_name_kana = 'ゲスト'
    customer.first_name_kana = 'ユーザー'
    customer.telephone_number = '09012345678'
    customer.password = SecureRandom.urlsafe_base64
      # user.skip_confirmation!  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def ensure_normal_customer
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの更新・削除はできません。'
    end
  end
end
