class CreateTimeSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :time_slots do |t|
      t.references :coach_calendar, null: false, foreign_key: true
      t.date :date
      t.time :start_time
      t.time :end_time
      t.string :group_type

      t.timestamps
    end
  end
end
