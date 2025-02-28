# frozen_string_literal: true

class CreateTrainingPackages < ActiveRecord::Migration[7.1]
  def change
    create_table :training_packages do |t|
      t.string :name, null: false
      t.text :description
      t.text :features
      t.decimal :price, precision: 10, scale: 2
      t.integer :duration_in_days
      t.string :package_type, default: 'group_training'
      t.string :training_type, default: 'group_training'
      t.string :duration, default: 'month'
      t.string :status, default: 'active'

      t.timestamps
    end
  end
end
