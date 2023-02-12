class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resources)
    root_path
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number])
    #devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
end
