class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :set_dashboard_root_path, if: :user_signed_in?

  private

  def set_dashboard_root_path
    # redirect_to dashboard_url
  end
end
