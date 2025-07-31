# frozen_string_literal: true

class Attendance < ApplicationRecord
  belongs_to :user

  validates :attended_at, presence: true
  validates :status, inclusion: { in: %w[present absent] }

  # Custom validation to ensure user is not already marked present for the same date
  validate :not_already_present_today, on: :create

  private

  def not_already_present_today
    return unless user.attendance.exists?(['DATE(attended_at) = ?', Time.zone.today])

    errors.add(:base, 'User has already been marked present today.')
  end
end
