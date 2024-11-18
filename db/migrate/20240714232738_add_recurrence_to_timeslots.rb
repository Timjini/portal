# frozen_string_literal: true

class AddRecurrenceToTimeslots < ActiveRecord::Migration[7.1]
  def change
    add_column :time_slots, :recurrence_rule, :string, null: true
    add_column :time_slots, :recurrence_end, :datetime, null: true
    add_column :time_slots, :slot_type, :string, default: 'CoachTimeSlot'
  end
end
