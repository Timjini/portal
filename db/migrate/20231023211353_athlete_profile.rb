# frozen_string_literal: true

class AthleteProfile < ActiveRecord::Migration[7.1]
  def change
    create_table :athlete_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :height
      t.string :weight
      t.string :email
      t.string :phone
      t.string :school_name
      t.string :address
      t.string :city
      t.string :power_of_ten
      t.integer :level

      # Add user_id as a foreign key
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
