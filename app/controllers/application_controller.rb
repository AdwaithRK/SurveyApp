class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :isadmin, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :avatar])
  end

  def check_signup
    unless user_signed_in?
      '/register/sign_up'
    end
  end

  def after_sign_in_path_for(resource)
    '/logged_in'
  end

end
