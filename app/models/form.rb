# frozen_string_literal: true

class Form < ApplicationRecord
  after_create -> { admin_notification_email }

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

  private # rubocop:disable Lint/UselessAccessModifier

  def admin_notification_email
    mailer = FormMailer.new(self)
    mailer.contact_form_submission
    Rails.logger.info('Admin Notification Email sent')
  end
end
