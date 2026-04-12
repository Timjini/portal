# frozen_string_literal: true

class AddStatusToTasterSessionBooking < ActiveRecord::Migration[7.1]
  def change
    add_column :taster_session_bookings, :status, :string, default: 'pending' # rubocop:disable Rails/BulkChangeTable
    add_column :taster_session_bookings, :start_time, :datetime
    add_column :taster_session_bookings, :location, :string
    add_column :taster_session_bookings, :emergency_contact_name, :string
    add_column :taster_session_bookings, :emergency_contact_phone, :string
    add_column :taster_session_bookings, :referral_source, :string
    add_column :taster_session_bookings, :internal_notes, :text
    add_column :taster_session_bookings, :reminder_sent_at, :datetime
  end
end
