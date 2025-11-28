# frozen_string_literal: true

class Attendance < ApplicationRecord
  belongs_to :user

  validates :attended_at, presence: true
  validates :status, inclusion: { in: %w[present absent] }

  # Custom validation to ensure user is not already marked present for the same date
  validate :not_already_present_today, on: :create

  private

  def not_already_present_today
    return if attended_at.blank?

    date_range = attended_at.to_date.all_day

    if Attendance.where(user_id: user_id)
                 .where(attended_at: date_range)
                 .where.not(id: id)
                 .exists?
      errors.add(:user, 'already has attendance recorded for this date.')
    end
  end
end
