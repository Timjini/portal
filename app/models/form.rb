# frozen_string_literal: true

class Form < ApplicationRecord
  validate :personal_information, on: :personal_info
  validate :contact_information, on: :contact_info

  enum :status, { new: 'new', fulfilled: 'fulfilled', archived: 'archived' }, prefix: true

  validates :email, presence: { message: 'must be given please' } # rubocop:disable Rails/I18nLocaleTexts
  validates :name, presence: { message: 'must be given please' } # rubocop:disable Rails/I18nLocaleTexts
  validates :phone, presence: { message: 'must be given please' } # rubocop:disable Rails/I18nLocaleTexts

  private

  def personal_information
    errors.add(:base, 'Name must be present') if first_name.blank?
  end

  def contact_information
    errors.add(:base, 'Name must be present') if name.blank?
    errors.add(:base, 'Email must be present') if email.blank?
    errors.add(:base, 'Phone number must be present') if phone.blank?
  end
end
