# frozen_string_literal: true

class TasterSessionBooking < ApplicationRecord
  belongs_to :training_package
  after_create -> { admin_notification_email }
  # after_create -> { generate_qr_code }
  has_one_attached :qr_code

  STATUSES = {
    pending: 'pending',
    confirmed: 'confirmed',
    completed: 'completed',
    cancelled: 'cancelled',
    no_show: 'no_show'
  }.freeze

  enum :status, STATUSES, default: :pending

  # belongs_to :user
  before_validation(on: :create) do
    self.training_package = TrainingPackage.first if training_package.nil?
  end

  def full_name_by_role
    role == 'athlete' ? "#{first_name} #{last_name}" : athlete_full_name
  end

  private

  def admin_notification_email
    return unless Rails.env.production?

    mailer = TasterSessionMailer.new(self)
    mailer.contact_form_submission
    Rails.logger.info('Admin Notification Email sent')
  end

  # def generate_qr_code
  #   QrCodeGeneratorService.call(self, 'https://club.chambersforsport.com')
  # end
end
