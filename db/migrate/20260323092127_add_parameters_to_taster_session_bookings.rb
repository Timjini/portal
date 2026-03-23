class AddParametersToTasterSessionBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :taster_session_bookings, :extra, :json
    change_table :taster_session_bookings, bulk: true do |t|
      t.boolean :registration_confirmation, default: false, null: false
      t.references :training_package, null: true, foreign_key: true
    end
    add_column :taster_session_bookings, :policy_agreement, :boolean, default: false, null: false
  end
end
