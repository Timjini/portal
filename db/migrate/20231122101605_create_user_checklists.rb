# frozen_string_literal: true

class CreateUserChecklists < ActiveRecord::Migration[7.1]
  def change
    create_table :user_checklists do |t|
      t.references :user_level, null: false, foreign_key: true
      t.references :check_list, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :completed
      t.string :title

      t.timestamps
    end
  end
end
