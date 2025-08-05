# frozen_string_literal: true

class CreateUserLogins < ActiveRecord::Migration[7.1]
  def change
    create_table :user_logins do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :login_at

      t.timestamps
    end
  end
end
