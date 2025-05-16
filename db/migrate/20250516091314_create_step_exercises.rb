# frozen_string_literal: true

class CreateStepExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :step_exercises do |t|
      t.references :step, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.integer :order

      t.timestamps
    end

    add_index :step_exercises, %i[step_id exercise_id], unique: true
  end
end
