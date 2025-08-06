class AddCompletedToAssessments < ActiveRecord::Migration[7.1]
  def change
    add_column :assessments, :completed, :boolean, default: false, null: false # rubocop:disable Rails/BulkChangeTable
    add_index :assessments, :completed
  end
end
