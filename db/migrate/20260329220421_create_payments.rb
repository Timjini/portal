# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.date :payment_date
      t.decimal :amount, precision: 10, scale: 2
      t.string :status, default: 'pending'
      t.date :due_date
      t.json :links
      t.belongs_to :user
      t.belongs_to :user_plan
      t.timestamps
    end
  end
end
