# frozen_string_literal: true

class SecondaryRecord < ApplicationRecord
  self.abstract_class = true

  # Establish connection when the class loads
  establish_connection(
    adapter: 'mysql2',
    host: ENV.fetch('DB_SECONDARY_HOST', nil),
    username: ENV.fetch('DB_SECONDARY_USERNAME', nil),
    password: ENV.fetch('DB_SECONDARY_PASSWORD', nil),
    database: ENV.fetch('DB_SECONDARY_NAME', nil),
    port: ENV.fetch('DB_SECONDARY_PORT', nil),
    ssl_mode: :verify_identity,
    sslca: '/etc/ssl/cert.pem',
    connect_timeout: 10,
    pool: ENV.fetch('RAILS_MAX_THREADS', 5).to_i
  )

  # Connection verification (optional)
  def self.verify_connection
    connection.pool.checkout
    connection.active?
    Rails.logger.debug '✅ Secondary database connection successful!'
    true
  rescue StandardError => e
    Rails.logger.debug { "❌ Secondary database connection failed: #{e.message}" }
    false
  ensure
    connection_pool.checkin(connection)
    Rails.logger.debug 'Secondary database connection returned to pool.'
  end
end
