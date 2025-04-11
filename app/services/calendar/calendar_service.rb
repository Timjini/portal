# frozen_string_literal: true

module Calendar
  class CalendarService
    def self.find_or_create_calendars(coach_ids)
      calendars = CoachCalendar.where(user_id: coach_ids).to_a
      return calendars if calendars.any?

      coach_ids.map { |id| CoachCalendar.create(user_id: id) }
    end
  end
end
