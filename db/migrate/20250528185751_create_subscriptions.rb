class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pricing_package, null: false, foreign_key: true
      t.string :status, null: false, default: 'active'
      t.string :payment_method, null: false
      t.string :billing_cycle, null: false, default: 'monthly'
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :currency, null: false, default: 'GBP'
      t.string :external_provider, null: false, default: 'manual'
      t.date :start_date, null: false
      t.date :end_date
      t.timestamps
    end
  end
end
