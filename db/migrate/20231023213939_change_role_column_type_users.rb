# frozen_string_literal: true

class ChangeRoleColumnTypeUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :role, :string, default: 'athlete'
  end
end
