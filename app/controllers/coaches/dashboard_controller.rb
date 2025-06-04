class Coaches::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # @coaching_sessions = current_user&.coaching_sessions.includes(:student, :course).order(created_at: :desc)
    # @students = current_user&.students.includes(:courses).order(:name) || []
    # @courses = current_user&.courses.order(:title) || []
  end

end