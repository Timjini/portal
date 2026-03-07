# frozen_string_literal: true

class CreateUserPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :user_plans do |t|
      t.belongs_to :user
      t.belongs_to :plan

      t.timestamps
    end
  end
end
