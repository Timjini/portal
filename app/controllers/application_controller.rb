# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  # before_action :set_dashboard_root_path, if: :user_signed_in?
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from StandardError, with: :render_error

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[email password password_confirmation username first_name last_name avatar
                                               phone address role parent_id])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[email password password_confirmation current_password username first_name
                                               last_name avatar phone address role parent_id])
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

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, alert: 'You are not authorized to access this page.' # rubocop:disable Rails/I18nLocaleTexts
  end

  def safe_action(action_name = nil)
    yield
  rescue StandardError => e
    Rails.logger.error "Error in #{controller_name}##{action_name || action_name_from_caller}: #{e.message}"
    ErrorLogger.log(e, context: {
                      controller: controller_name,
                      action: action_name || action_name_from_caller,
                      params: params.to_unsafe_h,
                      user_id: current_user&.id
                    })
    raise
  end

  private

  def action_name_from_caller
    caller_locations(1, 1)[0].label
  end

  # def set_dashboard_root_path
  #   redirect_to dashboard_url
  # end
end
