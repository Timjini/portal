# frozen_string_literal: true

class AddCoachCalendarIdToTimeSlots < ActiveRecord::Migration[7.1]
  def change
    add_column :time_slots, :coach_calendar_id, :bigint
  end
end
