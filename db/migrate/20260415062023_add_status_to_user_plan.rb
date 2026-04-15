# frozen_string_literal: true

class AddStatusToUserPlan < ActiveRecord::Migration[7.1]
  def change
    add_column :user_plans, :status, :string, default: 'pending'
  end
end
