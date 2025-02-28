# frozen_string_literal: true

class AddGoolgeAndAppleToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :apple_id, :string
    add_column :users, :google_id, :string
  end
end
