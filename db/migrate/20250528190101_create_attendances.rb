# frozen_string_literal: true

class CreateAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :attendances do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :attended_at, null: false
      t.string :status, null: false, default: 'present'
      t.timestamps
    end
  end
end
