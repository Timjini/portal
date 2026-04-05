# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :user_plan

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  enum :status, { active: 'active', pending: 'pending', failed: 'failed', retrying: 'retrying' }, default: 'active'

  def formatted_price
    "#{format('%.2f', amount.round / 100.0)} #{user_plan.plan.currency}"
  end
end
