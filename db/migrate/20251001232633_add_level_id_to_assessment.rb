# frozen_string_literal: true

class AddLevelIdToAssessment < ActiveRecord::Migration[7.1]
  def change
    return if column_exists?(:assessments, :level_id)

    add_reference :assessments, :level, null: false, foreign_key: true
  end
end
