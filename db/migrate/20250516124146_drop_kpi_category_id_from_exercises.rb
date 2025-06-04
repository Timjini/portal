# frozen_string_literal: true

class DropKpiCategoryIdFromExercises < ActiveRecord::Migration[7.1]
  def change
    remove_column :exercises, :kpi_category_id # rubocop:disable Rails/ReversibleMigration
  end
end
