# frozen_string_literal: true

class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      # Original fields
      t.string :name
      t.decimal :amount, precision: 10, scale: 2
      t.integer :day_of_month
      t.integer :day_of_week
      t.integer :month
      t.integer :interval
      t.string :interval_unit
      t.string :payment_reference
      t.string :currency

      t.string :status, default: 'active'
      t.string :redirect_url
      t.integer :count
      t.integer :scheme_notice_period
      t.boolean :has_pending_update,  default: false, null: false
      t.boolean :scheduled_to_pause,  default: false, null: false
      t.boolean :instant_bank_pay, default: false, null: false

      t.json :links
      t.json :organisation_details
      t.json :fx
      t.string :url

      t.timestamps
    end
  end
end
