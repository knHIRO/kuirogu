# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # def guest_sign_in
  #   customer = Customer.guest
  #   sign_in customer
  #   redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  # end

  # def guest_sign_in
  #   customer = Customer.find_or_create_by!(email: 'guest@example.com') do |customer|
  #     customer.first_name = 'Guest'
  #     customer.last_name = 'User'
  #     customer.last_name_kana = 'ゲスト'
  #     customer.first_name_kana = 'ユーザー'
  #     customer.telephone_number = '09012345678'
  #     customer.password = SecureRandom.urlsafe_base64
      # user.skip_confirmation!  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
  #   end
  #   sign_in customer
  #   redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  # end

  protected
# 退会しているかを判断するメソッド
  def customer_state
    ## 【処理内容1】 入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
    ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @customer.valid_password?(params[:customer][:password])
      ## 【処理内容3】
    if @customer.is_deleted
      redirect_to new_customer_registration_path
    end
    if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted
    redirect_to new_customer_registration_path
    end
    end
  end


end
