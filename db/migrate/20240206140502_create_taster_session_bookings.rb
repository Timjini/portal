class CreateTasterSessionBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :taster_session_bookings do |t|
      t.references :user, null: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :athlete_full_name
      t.string :email
      t.string :phone
      t.string :role
      t.date :birth_date
      t.date :taster_session_date
      t.text :health_issues


      t.timestamps
    end
  end
end
