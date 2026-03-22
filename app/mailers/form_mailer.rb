# frozen_string_literal: true

class FormMailer
  def initialize(form)
    @form = form
  end

  def contact_form_submission # rubocop:disable Metrics/MethodLength
    email_setting = {
      reset_url: @form.id,
      template_id: 2,
      to: ENV.fetch('ADMIN_EMAIL', nil),
      params: {
        request: @form.title,
        url: @form.id,
        full_name: @form.name,
        customer_email: @form.email,
        phone: @form.phone,
        subject: @form.subject,
        message: @form.message
      }
    }

    begin
      BrevoMailerService.new(email_setting).send
    rescue StandardError => e
      Rails.logger.error("Failed to send form mailer: #{e.message}")
    end
  end
end
