# frozen_string_literal: true

class ChangeRoleColumnTypeUsers < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :role, :string, default: 'athlete'
  end

  def down
    change_column :users, :role, :string, default: nil
  end
end
