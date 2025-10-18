# frozen_string_literal: true

class CompetitionEntry < ApplicationRecord
  belongs_to :user
  belongs_to :competition

  enum :status, {
    subscribed: 'subscribed',
    cancelled: 'cancelled'
  }, prefix: true
end
