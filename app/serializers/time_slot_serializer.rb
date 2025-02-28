# frozen_string_literal: true

class TimeSlotSerializer < ActiveModel::Serializer
  attributes :id, :date, :start_time, :end_time, :group_type
  has_one :coach_calendar
end
