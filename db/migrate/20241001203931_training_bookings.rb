class TrainingBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :training_bookings do |t|
      t.references :user, null: true, foreign_key: true
      t.references :training_package, null: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :athlete_full_name
      t.string :email
      t.string :phone
      t.text :address
      t.string :role
      t.date :birth_date
      t.text :health_issues
      t.string :training_package_name
      t.string :approval_status, default: 'pending'
      t.string :payment_status, default: 'pending'

      t.timestamps
    end
  end
end
