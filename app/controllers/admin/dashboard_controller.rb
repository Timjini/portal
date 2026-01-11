# frozen_string_literal: true

module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    authorize_resource class: false
    # layout "admin"

    def index # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
      @recent_logins = User.where.not(last_login_at: nil)
                           .order(last_login_at: :desc)
                           .limit(10)

      @recent_errors = AppError.order(created_at: :desc).limit(10)

      @system_overview = {
        total_users: User.count,
        active_users: User.where(active: true).count,
        last_login_at: @recent_logins.first&.last_login_at,
        recent_errors_count: @recent_errors.size
      }

      @system_alerts_count = AppError.count
      @active_users_count = User.where(active: true).count
      @inactive_accounts_count = User.where(active: false).count
      @assessments_completed = Assessment.where(completed: true).count
      @pending_approvals = 0

      @metrics = DashboardMetricsService.new(params[:time_range]).platform_activity
    end
  end
end
