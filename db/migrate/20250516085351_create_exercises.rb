# frozen_string_literal: true

class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.string :name, null: false
      t.references :kpi_category, null: false, foreign_key: true
      t.text :description

      # Common measurable fields
      t.integer :reps
      t.integer :sets
      t.integer :duration_secondsonds
      t.float :distance_meterseters

      # Gender specific benchmarks (optional)
      t.string :male_benchmark
      t.string :female_benchmark

      # media
      t.string :video_url
      t.integer :position, null: true

      # level
      t.string :difficulty_level
      t.string :intensity

      t.string :notes

      # target
      t.string :muscle_group
      t.string :primary_focus
      t.string :movement_patterns, array: true, default: []
      t.string :equipment, array: true, default: []
      # Flexible extra attributes stored here
      t.jsonb :extra_attributes, default: {}

      t.timestamps
    end

    # Index for jsonb column to optimize querying specific keys, if needed
    execute <<-SQL.squish # rubocop:disable Rails/ReversibleMigration
      CREATE INDEX index_exercises_on_extra_attributes ON exercises USING gin (extra_attributes);
    SQL
  end
end
