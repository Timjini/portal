# frozen_string_literal: true

class BrevoMailerService
  require 'brevo'

  Brevo.configure do |config|
    config.api_key['api-key'] = ENV.fetch('BREVO_API_KEY', nil)
  end

  attr_reader :user, :reset_url

  def initialize(user, reset_url)
    @user = user
    @reset_url = reset_url
  end

  def send_reset_password_email # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    Rails.logger.info("[BrevoMailerService] Preparing to send reset password email to #{user.email}")

    api_instance = Brevo::TransactionalEmailsApi.new

    email = Brevo::SendSmtpEmail.new(
      sender: { email: 'no-reply@club.chambersforsport.com', name: 'Club' },
      to: [{ email: user.email }],
      templateId: 1,
      params: {
        reset_url: reset_url
      }
    )

    Rails.logger.debug { "[BrevoMailerService] Email payload: #{email.to_hash.inspect}" }

    response = api_instance.send_transac_email(email)

    Rails.logger.info("[BrevoMailerService] Email sent successfully. Response: #{response.to_hash.inspect}")
    response
  rescue Brevo::ApiError => e
    Rails.logger.error("[BrevoMailerService] Brevo API Error: #{e.response_body}")
    Rails.logger.error(e.backtrace.join("\n"))
    nil
  rescue StandardError => e
    Rails.logger.error("[BrevoMailerService] Unexpected error: #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
    nil
  end
end
