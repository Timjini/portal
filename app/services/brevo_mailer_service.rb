# frozen_string_literal: true

class BrevoMailerService
  require 'brevo'

  Brevo.configure do |config|
    config.api_key['api-key'] = ENV.fetch('BREVO_API_KEY', nil)
  end

  def initialize(email_content)
    @email_content = email_content
  end

  def send
    api_instance = Brevo::TransactionalEmailsApi.new
    api_instance.send_transac_email(mailer_settings)
  rescue Brevo::ApiError => e
    Rails.logger.error("[BrevoMailerService] Brevo API Error: #{e.response_body}")
    Rails.logger.error(e.backtrace.join("\n"))
    nil
  end

  private

  def mailer_settings
    Brevo::SendSmtpEmail.new(
      sender: { email: ENV.fetch('PORTAL_SENDER_EMAIL', nil), name: 'Chambers For Sport Academy' },
      to: [{ email: @email_content[:user][:email] }],
      templateId: @email_content[:template_id],
      params: @email_content[:params]
    )
  end
end
