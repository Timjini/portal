# frozen_string_literal: true

class AddExtraDataToTrainingPackage < ActiveRecord::Migration[7.1]
  def change
    add_column :training_packages, :extra, :jsonb, default: {}, null: false
    add_index :training_packages, :extra, using: :gin
  end
end
