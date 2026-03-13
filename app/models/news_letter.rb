# frozen_string_literal: true

class NewsLetter < ApplicationRecord
  validates :name, presence: { message: 'must be given please' } # rubocop:disable Rails/I18nLocaleTexts
  validates :email, presence: { message: 'must be given please' } # rubocop:disable Rails/I18nLocaleTexts
end
