# frozen_string_literal: true

class CompetitionEntry < ApplicationRecord
  belongs_to :user
  belongs_to :competition

  validates :user_id, uniqueness: { scope: :competition_id, message: 'has already registered for this competition' } # rubocop:disable Rails/I18nLocaleTexts

  enum :status, {
    subscribed: 'subscribed',
    cancelled: 'cancelled'
  }, prefix: true

  def participants
    user_id
  end
end
