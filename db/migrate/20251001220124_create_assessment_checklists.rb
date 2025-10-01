class CreateAssessmentChecklists < ActiveRecord::Migration[7.1]
  def change
    create_table :assessment_checklists do |t|
      t.bigint :assessment_id, null: false
      t.bigint :check_list_id, null: false

      t.timestamps
    end

    add_foreign_key :assessment_checklists, :assessments
    add_foreign_key :assessment_checklists, :check_lists

    add_index :assessment_checklists, [:assessment_id, :check_list_id], unique: true
  end
end
