# frozen_string_literal: true

class FormMailer < ApplicationMailer
  def contact_form_submission(form_data)
    email_setting = {
      reset_url: form_data.id,
      template_id: 2,
      to: ENV.fetch('ADMIN_EMAIL', nil),
      params: {
        request: form_data.title,
        url: form.id,
        full_name: form_data.name,
        customer_email: form_data.email,
        phone: form_data.phone,
        subject: form_data.subject,
        message: form_data.message,
      }
    }

    begin
      BrevoMailerService.new(email_setting).send
    rescue StandardError => e
      Rails.logger.error("Failed to send form mailer: #{e.message}")
    end
  end
end
