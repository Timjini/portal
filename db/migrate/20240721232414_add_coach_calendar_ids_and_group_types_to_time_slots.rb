class AddCoachCalendarIdsAndGroupTypesToTimeSlots < ActiveRecord::Migration[7.1]
  def change
    add_column :time_slots, :coach_calendar_ids, :text, array: true, default: []
    add_column :time_slots, :group_types, :text, array: true, default: []
    remove_column :time_slots, :coach_calendar_id, :integer
    remove_column :time_slots, :group_type, :string
  end
end
