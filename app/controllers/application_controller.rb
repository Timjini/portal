class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :set_dashboard_root_path, if: :user_signed_in?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :username, :first_name, :last_name,:avatar, :phone, :address])
      devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, :username, :first_name, :last_name,:avatar, :phone, :address ])
  end

  private

  def set_dashboard_root_path
    # redirect_to dashboard_url
  end
end
