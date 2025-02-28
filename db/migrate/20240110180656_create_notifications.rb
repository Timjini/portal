# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.text :body
      t.boolean :viewed
      t.references :notifiable, polymorphic: true, null: false
      t.string :category

      t.timestamps
    end
  end
end
