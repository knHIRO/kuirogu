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

  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
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





  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(resources)
    root_path
  end

  def after_sign_out_path_for(resources)
    root_path
  end

  protected


end
