# frozen_string_literal: true

class CoachCalendarService
  def initialize(params = {})
    @params = params
  end

  def fetch_all_calendars # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    calendars = CoachCalendar.includes(:time_slots)
    return [] unless calendars.any?

    time_slots = TimeSlot.all
    time_slots.map do |time_slot|
      coach_data = extract_coach_data(time_slot)

      {
        id: time_slot.id,
        title: time_slot.title,
        groups: time_slot.group_type_list,
        coach: coach_data[:names].join(', '),
        start: "#{time_slot.date}T#{time_slot.start_time.strftime('%H:%M:%S')}",
        end: "#{time_slot.date}T#{time_slot.end_time.strftime('%H:%M:%S')}",
        color: coach_data[:colors].join(', '),
        url: "/time_slots/#{time_slot.id}"
      }
    end
  end

  def fetch_calendar_by_user # rubocop:disable Metrics/MethodLength
    user_id = @params[:user_id]
    calendar = CoachCalendar.find_by(user_id: user_id)
    return nil if calendar.nil?

    time_slots = TimeSlot.where(coach_calendar_id: calendar.id).map do |time_slot|
      {
        id: time_slot.id,
        title: time_slot.group_type,
        start: "#{time_slot.date}T#{time_slot.start_time.strftime('%H:%M:%S')}",
        end: "#{time_slot.date}T#{time_slot.end_time.strftime('%H:%M:%S')}",
        color: 'green'
      }
    end

    { calendar: calendar, time_slots: time_slots }
  end

  def fetch_calendar_with_time_slots
    user_id = @params[:user_id]
    CoachCalendar.where(user_id: user_id).includes(:time_slots)
  end

  def fetch_all_calendars_only
    CoachCalendar.includes(:time_slots)
  end

  private

  def extract_coach_data(time_slot)
    coach_ids = time_slot.coach_calendar_ids.uniq
    coaches = User.where(id: coach_ids)

    {
      names: coaches.map(&:full_name),
      colors: coaches.map(&:color)
    }
  end
end
