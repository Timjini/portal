# frozen_string_literal: true

class UserPlan < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  STATUSES = {
    pending: 'pending',
    processing: 'processing',
    confirmed: 'active',
    cancelled: 'cancelled',
  }.freeze

  enum :status, STATUSES, default: :pending
end
