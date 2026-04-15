# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :user_plan
  after_create -> { update_user_plan_status }

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  enum :status, { active: 'active', pending: 'pending', failed: 'failed', retrying: 'retrying' }, default: 'active'

  def formatted_price
    "#{format('%.2f', amount.round / 100.0)} #{user_plan.plan.currency}"
  end

  def update_user_plan_status
  begin
    plan = self.user_plan
    plan.status = 'processing'
    plan.save
  rescue StandardError => e 
    Rails.logger.info("Issue updating user plan status to processing")
  end
  end
end
