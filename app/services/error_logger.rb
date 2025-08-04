# frozen_string_literal: true

class ErrorLogger
  def self.log(error, context: {})
    AppError.create!(
      error_type: error.class.to_s,
      message: error.message,
      backtrace: error.backtrace&.take(20)&.join("\n"),
      occurred_at: Time.current,
      context: context
    )
  rescue StandardError => e
    Rails.logger.error "Failed to log error: #{e.message}"
  end
end
