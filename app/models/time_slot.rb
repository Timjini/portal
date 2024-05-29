class TimeSlot < ApplicationRecord
  belongs_to :coach_calendar

  enum group_type: { development: 0, intermediate: 1, advanced: 2}
end
