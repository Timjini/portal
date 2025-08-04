# frozen_string_literal: true

class AttendanceController < ApplicationController
  before_action :authenticate_user!

  # load_and_authorize_resource
  def index
    @users = User.where(role: %i[child_user athlete_user]).paginate(page: params[:page], per_page: 10)
  end

  def create # rubocop:disable Metrics/MethodLength,Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    users_status = params.dig(:attendance, :users) || {}

    if params[:attendance].blank? || users_status.blank?
      render json: { error: 'No attendance data provided.' }, status: :unprocessable_entity
      return
    end

    users_status = params.dig(:attendance, :users) || {}
    if users_status.empty?
      render json: { error: 'No users selected for attendance.' }, status: :unprocessable_entity
      return
    end
    users_status.each do |user_id, present_value|
      status = present_value == '1' ? 'present' : 'absent'

      # If you have unique attendance per day, find or create
      attendance = Attendance.find_or_initialize_by(
        user_id: user_id,
        attended_at: Time.zone.today.all_day
      )
      attendance.status = status
      attendance.attended_at ||= Time.zone.now
      attendance.save!
    end

    render json: { message: 'Attendance recorded successfully.' }, status: :created
  rescue StandardError => e
    Rails.logger.error "Error recording attendance: #{e.message}"
    render json: { error: "Failed to record attendance. #{e.message}" }, status: :unprocessable_entity
  end
end
