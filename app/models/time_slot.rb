class TimeSlot < ApplicationRecord
  belongs_to :coach_calendar

  enum group_type: { development: "development", intermediate: "intermediate", advanced: "advanced"}
  enum slot_type: { coach_slot: "Coach Slot", taster_session_bookings: "Taster Session Booking"}
  validates :recurrence_rule, inclusion: { in: %w[none daily weekly monthly], message: "%{value} is not a valid recurrence rule" }, allow_nil: true
  # validates :recurrence_end, presence: true, if: -> { recurrence_rule.present? }

end
