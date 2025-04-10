# frozen_string_literal: true

class DropCoachCalendarIdsFromTimeSlot < ActiveRecord::Migration[7.1]
  def change
    change_table :time_slots do |t|
      t.remove :coach_calendar_ids, type: :text
    end
  end
end
