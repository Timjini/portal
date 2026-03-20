# frozen_string_literal: true

class TasterBooking < ApplicationRecord
  self.table_name = 'training_bookings'
  alias_attribute :status, :approval_status

  enum :status, {
    pending: 'pending',
    confirmed: 'confirmed',
    cancelled: 'cancelled'
  }, prefix: true

  # Optional: Add scopes for convenience
  scope :active, -> { where(status: %w[pending confirmed]) }
  scope :inactive, -> { where(status: 'cancelled') }

  # Optional: Add validation
  validates :status, inclusion: { in: statuses.keys }

  def cancelled?
    status_cancelled?
  end
end
