# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'
require 'dotenv/load'
# require 'sendgrid-ruby'
# this should be fixed here
# include SendGrid

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Portal
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Allow the app to be iframed on replit.com
    config.action_dispatch.default_headers = {
      'X-Frame-Options' => 'ALLOWFROM replit.com'
    }

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # config.action_controller.default_url_options = { host: 'chambersforsport.net', protocol: 'https' }
    config.action_mailer.default_url_options = { host: 'club.chambersforsport.com', protocol: 'https' }
    # config.action_mailer.default_url_options = { host: 'chambersforsport.net' }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true

    config.assets.compile = true

    config.assets.enabled = true

    # require 'dotenv/load' if (ENV['RUBY_ENV'] == "development" || ENV['RUBY_ENV'] == "test")

    # load paths
    # config.autoload_paths += %W[
    #   #{config.root}/app/errors
    #   #{config.root}/app/queries
    # ]

    # production
    # config.action_controller.default_url_options = { host: 'chambersforsport.net' }

    # development
    # config.action_controller.default_url_options = { host: 'localhost:3000' }

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'London'
    config.active_record.default_timezone = :utc
    config.i18n.default_locale = :en
    config.i18n.fallbacks = true
    # config.eager_load_paths << Rails.root.join("extras")
    #
    # Disable the generation of system test files.
    # config.autoload_paths -= %W[#{config.root}/app/disabled]
  end
end
