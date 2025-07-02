# frozen_string_literal: true

class CreateDcpaEvents < ActiveRecord::Migration[7.1]
  def change
    return if table_exists?(:dcpa_events)

    create_table :dcpa_events do |t|
      t.string :title
      t.string :coach
      t.json :dates
      t.time :time_start
      t.time :time_end
      t.string :location
      t.string :ages_available
      t.decimal :price
      t.decimal :dcpa_discount
      t.string :extras
      t.string :event_type
      t.string :status

      t.timestamps
    end
  end
end
