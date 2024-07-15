class CoachCalendarController < ApplicationController

    def index 
        @calendar = CoachCalendar.includes(:time_slots)
        # render json: @calendar
    end

    def show
        @calendar = CoachCalendar.where(userd_id: params[:id]).includes(:time_slots)
    end

     def calendar_data
        user_id = params[:user_id]
        @calendar = CoachCalendar.find_by(user_id: user_id)
        
        if @calendar
            @time_slots = TimeSlot.where(coach_calendar_id: @calendar.id)

            time_slots = @time_slots.map do |time_slot|
                {
                id: time_slot.id,
                title: time_slot.group_type,
                start: "#{time_slot.date}T#{time_slot.start_time.strftime("%H:%M:%S")}",
                end: "#{time_slot.date}T#{time_slot.end_time.strftime("%H:%M:%S")}",
                color: 'green'
                }
            end
                render json: time_slots
            else
                render json: { error: "No calendar found for user with ID #{user_id}" }, status: :not_found
        end
    end

    def all_calendars
        @calendars = CoachCalendar.all
        if @calendars
            time_slots = TimeSlot.all

            time_slots_map = time_slots.map do |time_slot|
                {
                id: time_slot.id,
                title: time_slot.group_type,
                start: "#{time_slot.date}T#{time_slot.start_time.strftime("%H:%M:%S")}",
                end: "#{time_slot.date}T#{time_slot.end_time.strftime("%H:%M:%S")}",
                color: 'green'
                }
            end
                render json: time_slots_map
            else
                render json: { error: "No calendar found" }, status: :not_found
        end
    end
end