# frozen_string_literal: true

class AttendanceController < ApplicationController
  before_action :authenticate_user!

  # load_and_authorize_resource
  def index
    @users = User.where(role: %i[child_user athlete_user])
  end

  def create # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    attendances_data = params[:attendance]
    date = params[:date]
    session = params[:session]
    custom_time = params[:custom_time]
  
    attendances_saved = attendances_data.all? do |att|
      attended_at = if session == 'custom'
                      "#{date} #{custom_time}"
                    else
                      # Optional mapping for session times
                      time_map = {
                        'morning' => '08:00',
                        'afternoon' => '14:00',
                        'evening' => '18:00'
                      }
                      "#{date} #{time_map[session]}"
                    end
  
      Attendance.create(
        user_id: att[:user_id],
        attended_at: attended_at,
        status: att[:present] ? 'present' : 'absent'
      )
    end

    if attendances_saved
      render json: { message: 'Attendance recorded.' }, status: :created
    else
      render json: { error: 'Failed to record some attendance entries.' }, status: :unprocessable_entity
    end
  end

end
