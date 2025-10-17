# frozen_string_literal: true

class AddCompletedAtToAssessments < ActiveRecord::Migration[7.1]
  def change
    add_column :assessments, :completed_at, :datetime
  end
end
