# frozen_string_literal: true

class AddExtraDataToTrainingPackage < ActiveRecord::Migration[7.1]
  def change
    add_column :training_packages, :extra, :json, default: {}, null: false
    # MySQL does NOT support GIN indexes, so remove this line:
    # add_index :training_packages, :extra, using: :gin
  end
end
