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

  if @calendars.any?
    time_slots = TimeSlot.all
    time_slots_map = time_slots.map do |time_slot|
      # Find unique coaches for the time_slot
      coach_ids = time_slot.coach_calendar_ids.uniq
      coaches = User.where(id: coach_ids)

      # Map coach data ensuring no duplicates
      coach_data = coaches.map do |coach|
        {
          name: coach.full_name,
          color: coach.color,
          image: coach.avatar, # Assuming you want to include this in the future
          url: "/users/#{coach.id}"
        }
      end

      # Aggregate unique coach names and colors
      coach_names = coach_data.map { |data| data[:name] }
      coach_colors = coach_data.map { |data| data[:color] }

      {
        id: time_slot.id,
        title: time_slot.title,
        groups: time_slot.group_type_list,
        coach: coach_names.join(', '), # Convert array to string with comma separation
        start: "#{time_slot.date}T#{time_slot.start_time.strftime('%H:%M:%S')}",
        end: "#{time_slot.date}T#{time_slot.end_time.strftime('%H:%M:%S')}",
        color: coach_colors.join(', '), # Convert array to string with comma separation
        url: "/time_slots/#{time_slot.id}"
      }
    end

    render json: time_slots_map
  else
    render json: { error: "No calendar found" }, status: :not_found
  end
end

end