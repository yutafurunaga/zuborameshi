class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller? 

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:family_name, :personal_name, :family_name_kana, :personal_name_kana])
  end
end