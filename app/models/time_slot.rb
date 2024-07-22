class TimeSlot < ApplicationRecord
  # serialize :coach_calendar_ids, JSON
  # serialize :group_types, JSON

  # validates :coach_calendar_ids, presence: true 
  # validates :group_types, presence: true

  # enum group_type: { development: "development", intermediate: "intermediate", advanced: "advanced"}
  enum slot_type: { coach_slot: "Coach Slot", taster_session_bookings: "Taster Session Booking"}
  validates :recurrence_rule, inclusion: { in: %w[none day week month], message: "%{value} is not a valid recurrence rule" }, allow_nil: true
  # validates :recurrence_end, presence: true, if: -> { recurrence_rule.present? }
  # 
  def coach_name
    calendars = CoachCalendar.where(id:self.coach_calendar_ids)
    if !calendars.nil?
    coach_names = calendars.map { |calendar| calendar.user.full_name }
    coach_names.join(', ')
    else
      "No coach assigned"
    end
  end

  def group_type_list
    if !self.group_types.nil?
    self.group_types.join(', ')
    else 
      "No group type assigned"
    end
  end

end
