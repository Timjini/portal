# frozen_string_literal: true

class AddCoachCalendarIdsAndGroupTypesToTimeSlots < ActiveRecord::Migration[7.1]
  def change
    add_column :time_slots, :coach_calendar_ids, :json, default: [] # rubocop:disable Rails/BulkChangeTable
    add_column :time_slots, :group_types, :json, default: []
    remove_column :time_slots, :coach_calendar_id, :integer
    remove_column :time_slots, :group_type, :string
  end
end
