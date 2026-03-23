# frozen_string_literal: true

class TasterSessionMailer
  def initialize(taster_session)
    @taster_session = taster_session
  end

  def contact_form_submission
    BrevoMailerService.new(payload).send
  rescue StandardError => e
    Rails.logger.error("Failed to send form mailer: #{e.message}")
  end

  private

  def payload # rubocop:disable Metrics/MethodLength
    {
      reset_url: @taster_session.id,
      template_id: 3,
      to: ENV.fetch('ADMIN_EMAIL', nil),
      params: {
        request: @taster_session.training_package.name,
        role: @taster_session.role,
        url: @taster_session.id,
        full_name: @taster_session.full_name_by_role,
        customer_email: @taster_session.email,
        phone: @taster_session.phone,
        taster_session_date: @taster_session.taster_session_date,
        birth_date: @taster_session.birth_date,
        health_issues: @taster_session.health_issues,
        training_package_price: @taster_session.training_package.price
      }
    }
  end
end
