# frozen_string_literal: true

class CreatePricingPackages < ActiveRecord::Migration[7.1]
  def change
    create_table :pricing_packages do |t|
      t.string  :name, null: false
      t.decimal :price_per_session, precision: 8, scale: 2
      t.decimal :monthly_fee, precision: 8, scale: 2
      t.string  :billing_type, null: false, default: 'per_session'
      t.integer :sessions_per_month, null: false, default: 0
      t.integer :minimum_commitment_months, null: false, default: 0
      t.boolean :active, null: false, default: true
      t.boolean :requires_commitment, null: false, default: false
      t.boolean :requires_payment_method, null: false, default: true
      t.boolean :requires_approval, null: false, default: false
      t.boolean :requires_contract, null: false, default: false
      t.boolean :requires_terms_of_service, null: false, default: true
      t.boolean :requires_privacy_policy, null: false, default: true
      t.boolean :requires_marketing_consent, null: false, default: false
      t.text    :description
      t.timestamps
    end
  end
end
