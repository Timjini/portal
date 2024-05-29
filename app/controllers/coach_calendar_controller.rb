class CoachCalendarController < ApplicationController

    def index 
        @calendar = CoachCalendar.includes(:time_slots)
        # render json: @calendar
    end

    def calendar_data
        @calendar = CoachCalendar.find_by(user_id: current_user.id)
        @time_slots = TimeSlot.where(coach_calendar_id: @calendar.id)
        render json: @time_slots 
    end
end