# frozen_string_literal: true

class CreateSteps < ActiveRecord::Migration[7.1]
  def change
    create_table :steps do |t|
      t.references :athlete_level_category, null: false, foreign_key: true
      t.integer :step_number, null: false

      t.timestamps
    end

    add_index :steps, %i[athlete_level_category_id step_number], unique: true,
                                                                 name: 'index_steps__category_and_number'
  end
end
