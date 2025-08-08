# frozen_string_literal: true

class TasterBooking < SecondaryRecord
  self.table_name = 'booking_data'

  enum status: {
    pending: 'pending',
    confirmed: 'confirmed',
    cancelled: 'cancelled'
  }, _prefix: true

  # Optional: Add scopes for convenience
  scope :active, -> { where(status: %w[pending confirmed]) }
  scope :inactive, -> { where(status: 'cancelled') }

  # Optional: Add validation
  validates :status, inclusion: { in: statuses.keys }

  def cancelled?
    status_cancelled?
  end
end
