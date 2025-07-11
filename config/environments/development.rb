# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.after_initialize do
    Bullet.enable        = true
    Bullet.alert         = true
    Bullet.bullet_logger = true
    Bullet.console       = true
    Bullet.rails_logger  = true
    Bullet.add_footer    = true
  end

  # Settings specified here will take precedence over those in config/application.rb.

  # white list
  config.hosts << /.*\.replit.dev/
  config.hosts << /[a-z0-9]+\.c9users\.io/
  config.hosts << /[a-z0-9]+\.c9\.io/
  # config.hosts << "chambersforsport.net"
  config.hosts << 'chambersforsport.com'
  config.hosts << 'club.chambersforsport.com'
  config.hosts << '8479a2bf-419f-49bc-9188-35a6ebba13a8-00-1xdo3hgux5i0q.kirk.replit.dev'
  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.enable_reloading = true

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  config.assets.compile = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local
  # config.active_storage.service = :cloudflare

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.logger = Logger.new($stdout)
  config.action_mailer.logger.level = Logger::DEBUG

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Highlight code that enqueued background job in logs.
  config.active_job.verbose_enqueue_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.public_file_server.enabled = true

  # Mailcatcher
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = { :address => '127.0.0.1', :port => 1025 }
  # config.action_mailer.raise_delivery_errors = false

  # trapmail Setup
  config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #   user_name: ENV.fetch('MAILTRAP_USERNAME', nil),
  #   password: ENV.fetch('MAILTRAP_PASSWORD', nil),
  #   address: 'sandbox.smtp.mailtrap.io',
  #   host: 'sandbox.smtp.mailtrap.io',
  #   port: '2525',
  #   authentication: :login
  # }

  config.action_mailer.smtp_settings = {
    user_name: 'apikey',
    password: ENV.fetch('SEND_GRID_SECRET', nil),
    domain: 'chambersforsport.com',
    address: 'smtp.sendgrid.net',
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true

  # Raise error when a before_action's only/except options reference missing actions
  config.action_controller.raise_on_missing_callback_actions = true
end
