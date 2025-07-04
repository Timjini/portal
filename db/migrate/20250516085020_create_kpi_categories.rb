# frozen_string_literal: true

class CreateKpiCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :kpi_categories do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
