class TimeSlot < ApplicationRecord
  belongs_to :coach_calendar

  enum group_type: { development: "development", intermediate: "intermediate", advanced: "advanced"}
end
