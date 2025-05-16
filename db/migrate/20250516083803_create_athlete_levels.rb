# frozen_string_literal: true

class CreateAthleteLevels < ActiveRecord::Migration[7.1]
  def change
    create_table :athlete_levels do |t|
      t.string :name, null: false  # remove unique: true here
      t.integer :position, null: false, default: 0
      t.text    :description
      t.integer :min_age
      t.integer :max_age
      t.string  :color
      t.boolean :active, default: true # rubocop:disable Rails/ThreeStateBooleanColumn

      t.timestamps
    end

    # Add unique index on name
    add_index :athlete_levels, :name, unique: true
  end
end
