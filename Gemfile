# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.2'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use sqlite3 as the database for Active Record
# gem "sqlite3", "~> 1.4"
gem 'pg'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
gem 'redis', '>= 4.0.1'

gem 'esbuild-rails'

# Qr generator
gem 'rqrcode'

# sendgrid
gem 'sendgrid-ruby'

gem 'active_model_serializers', '~> 0.10.2'
# gem 'tailwindcss-rails', '~> 2.3'

gem 'aws-sdk-s3', '~> 1.136', require: false
gem 'image_processing', '~> 1.2'

gem 'activestorage', '7.1.2'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'

gem 'sidekiq', '~> 7.1', '>= 7.1.2'
gem 'sidekiq-cron', '~> 1.2'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'    
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  gem 'error_highlight', '>= 0.4.0', platforms: [:ruby]
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end

gem 'elasticsearch'
gem 'searchkick'

gem 'devise', '~> 4.9'

gem 'will_paginate'

gem 'byebug', group: :development

gem 'rack-cors'

gem 'guard-livereload', '~> 2.5', require: false
gem 'jwt'

gem 'recurrence', '~> 1.3'
gem 'tailwindcss-rails'
# gem 'mailersend-ruby', '~> 2.0.3'
gem 'ffi', '~> 1.9', '>= 1.9.10'
gem 'rubocop', '~> 1.67'

gem 'mailtrap', '~> 0.1.0'
