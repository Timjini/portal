# frozen_string_literal: true

class AttendanceController < ApplicationController
  before_action :authenticate_user!

  # load_and_authorize_resource
  def index # rubocop:disable Metrics/AbcSize
    @users = User.where(role: %i[child_user athlete])
                 .paginate(page: params[:page], per_page: 10)
                 .order(username: :asc)

    @users = @users.with_level(params[:level]) if params[:level].present?

    return if params[:name].blank?

    user_name = params[:name].strip.downcase
    @users = @users.where(
      'users.first_name LIKE :q OR users.last_name LIKE :q OR users.username LIKE :q OR users.email LIKE :q',
      q: "%#{user_name}%"
    )
  end

  def create # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    selected_date = if params[:attendance][:attended_at].present?
                      Date.parse(params[:attendance][:attended_at])
                    else
                      Time.zone.today
                    end

    users_status = params.dig(:attendance, :users) || {}

    users_status.each do |user_id, present_value|
      status = present_value == '1' ? 'present' : 'absent'

      attendance = Attendance.find_or_initialize_by(
        user_id: user_id,
        attended_at: selected_date
      )

      attendance.status = status
      attendance.attended_at = selected_date
      attendance.save!
    end

    render json: { message: 'Attendance recorded successfully.' }, status: :created
  end

  def fetch
    date = params[:date].present? ? Date.parse(params[:date]) : Time.zone.today
    records = Attendance.where(attended_at: date.all_day)

    render json: records.map { |a| { user_id: a.user_id, status: a.status } }
  end
end
