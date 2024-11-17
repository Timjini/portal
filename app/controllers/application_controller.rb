class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  # before_action :set_dashboard_root_path, if: :user_signed_in?
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from StandardError, with: :render_error


  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :username, :first_name, :last_name,:avatar, :phone, :address, :role, :parent_id])
      devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, :username, :first_name, :last_name,:avatar, :phone, :address, :role ,:parent_id ])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end

  def render_success(serialized_data, status: :ok)
    render json: { status: 'success' }.merge(serialized_data.as_json), status:
  end

  def render_error(message = 'Something went wrong', status: :unprocessable_entity)
    render json: { status: 'error', message: }, status:
  end

  def render_not_found(message = 'Record not found')
    render json: { status: 'error', message: }, status: :not_found
  end

  private

  # def set_dashboard_root_path
  #   redirect_to dashboard_url
  # end
end
