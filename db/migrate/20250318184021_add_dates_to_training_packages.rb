# frozen_string_literal: true

class AddDatesToTrainingPackages < ActiveRecord::Migration[7.1]
  def change
    add_column :training_packages, :start_date, :date # rubocop:disable Rails/BulkChangeTable
    add_column :training_packages, :ending_date, :date
  end
end
