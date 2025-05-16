# frozen_string_literal: true

class CreateAthleteLevelCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :athlete_level_categories do |t|
      t.references :athlete_level, null: false, foreign_key: true
      t.references :kpi_category, null: false, foreign_key: true
      t.timestamps
    end

    add_index :athlete_level_categories, %i[athlete_level_id kpi_category_id], unique: true
  end
end
