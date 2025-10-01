class AddLevelIdToAssessment < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:assessments, :level_id)
      add_reference :assessments, :level, null: false, foreign_key: true
    end
  end
end
