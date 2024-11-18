# frozen_string_literal: true

class TimeSlot < ApplicationRecord
  # serialize :coach_calendar_ids, JSON
  # serialize :group_types, JSON

  # validates :coach_calendar_ids, presence: true
  # validates :group_types, presence: true

  # enum group_type: { development: "development", intermediate: "intermediate", advanced: "advanced"}
  enum :slot_type, { coach_slot: 'Coach Slot', taster_session_bookings: 'Taster Session Booking' }
  validates :recurrence_rule,
            inclusion: { in: %w[none day week month], message: '%<value>s is not a valid recurrence rule' }, allow_nil: true
  # validates :recurrence_end, presence: true, if: -> { recurrence_rule.present? }
  #
  def coach_name
    calendars = CoachCalendar.where(id: coach_calendar_ids)
    if calendars.nil?
      'No coach assigned'
    else
      coach_names = calendars.map { |calendar| calendar.user.full_name }
      coach_names.join(', ')
    end
  end

  def group_type_list
    if group_types.nil?
      'No group type assigned'
    else
      group_types.join(', ')
    end
  end

  def url
    "/time_slots/#{id}"
  end

  def coach_names
    calendars = CoachCalendar.where(id: coach_calendar_ids)
    if calendars.nil?
      'No coach assigned'
    else
      coach_names = calendars.map { |calendar| calendar.user.full_name }
      coach_names.join(', ')
    end
  end

  def coach_data
    calendars = CoachCalendar.where(id: coach_calendar_ids).uniq

    return [] if calendars.blank?

    unique_coaches = {}

    calendars.each do |calendar|
      coach = calendar.user
      unique_coaches[coach.id] = {
        id: coach.id,
        name: coach.full_name,
        color: coach.color,
        image: coach.avatar,
        url: "/users/#{coach.id}"
      }
    end

    unique_coaches.values
  end
end
