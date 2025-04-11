# frozen_string_literal: true

module Calendar
  class CoachCalendarService
    def initialize(params = {})
      @params = params
    end

    def fetch_all_calendars # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      calendars = CoachCalendar.includes(:time_slots).includes(:user)
      return [] unless calendars.any?

      time_slots = TimeSlot.includes(coach_calendar: :user)
      time_slots.map do |time_slot|
        {
          id: time_slot.id,
          title: time_slot.title,
          groups: time_slot.group_type_list,
          coach: time_slot.coach_calendar.user.full_name,
          start: "#{time_slot.date}T#{time_slot.start_time.strftime('%H:%M:%S')}",
          end: "#{time_slot.date}T#{time_slot.end_time.strftime('%H:%M:%S')}",
          backgroundColor: time_slot.coach_calendar.user.color,
          borderColor: time_slot.coach_calendar.user.color,
          url: "/time_slots/#{time_slot.id}"
        }
      end
    end

    def fetch_calendar_by_user # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
      user_id = @params[:user_id]
      calendar = CoachCalendar.find_by(user_id: user_id)
      return nil if calendar.nil?

      time_slots = TimeSlot.where(coach_calendar_id: calendar.id).map do |time_slot|
        {
          id: time_slot.id,
          title: time_slot.group_type_list,
          start: "#{time_slot.date}T#{time_slot.start_time.strftime('%H:%M:%S')}",
          end: "#{time_slot.date}T#{time_slot.end_time.strftime('%H:%M:%S')}",
          backgroundColor: time_slot.coach_calendar.user.color,
          borderColor: time_slot.coach_calendar.user.color
        }
      end

      { calendar: calendar, time_slots: time_slots }
    end

    def fetch_calendar_with_time_slots
      user_id = @params[:user_id]
      CoachCalendar.where(user_id: user_id).includes(%i[time_slots user])
    end

    def fetch_all_calendars_only
      CoachCalendar.includes(%i[time_slots user])
    end
  end
end
