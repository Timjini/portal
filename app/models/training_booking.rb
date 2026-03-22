# frozen_string_literal: true

class TrainingBooking < ApplicationRecord
  belongs_to :training_package
  after_create -> { admin_notification_email }

  # belongs_to :user
  before_validation(on: :create) do
    self.training_package = TrainingPackage.first if training_package.nil?
  end

  private

  def admin_notification_email
    mailer = FormMailer.new(self)
    mailer.contact_form_submission
    Rails.logger.info('Admin Notification Email sent')
  end
end
