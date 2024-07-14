class TimeSlot < ApplicationRecord
  belongs_to :coach_calendar

  enum group_type: { development: "development", intermediate: "intermediate", advanced: "advanced"}
  validates :recurrence_rule, inclusion: { in: %w[daily weekly monthly], message: "%{value} is not a valid recurrence rule" }, allow_nil: true
  validates :recurrence_end, presence: true, if: -> { recurrence_rule.present? }

end
