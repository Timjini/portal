# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.1.2'

gem 'rails', '~> 7.1.2'
gem 'pg'
gem 'puma', '>= 5.0'

# assets and JS bundling
gem 'sprockets-rails'
gem 'jsbundling-rails'
gem 'cssbundling-rails'
gem 'esbuild-rails'
gem 'tailwindcss-rails'

# Hotwire
gem 'turbo-rails'
gem 'stimulus-rails'

# json api here need to add fastAPI ?
gem 'jbuilder'
gem 'active_model_serializers', '~> 0.10.2'

# Background jobs with redis/sidekiq
gem 'sidekiq', '~> 7.1', '>= 7.1.2'
gem 'sidekiq-cron', '~> 1.2'

# Storage
gem 'activestorage', '7.1.2'
gem 'aws-sdk-s3', '~> 1.136', require: false 
gem 'image_processing', '~> 1.2'

# Redis
gem 'redis', '>= 4.0.1'

# Authentication & security
gem 'devise', '~> 4.9'
gem 'jwt'

# Error tracking
gem 'sentry-rails'
gem 'sentry-ruby'

# Utilities
gem 'rqrcode'
gem 'sendgrid-ruby'
gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
gem 'rack-cors'
gem 'will_paginate'
gem 'recurrence', '~> 1.3'
gem 'elasticsearch'
gem 'searchkick'
gem 'mailtrap', '~> 0.1.0'

# dev tools
gem 'rubocop', '~> 1.67'
gem 'rubocop-performance', require: false
gem 'rubocop-rails', require: false
gem 'guard-livereload', '~> 2.5', require: false

# compatibility on some platforms
gem 'tzinfo-data', platforms: %i[windows jruby]
gem 'ffi', '~> 1.9', '>= 1.9.10'
gem 'bootsnap', require: false

group :development, :test do
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
  gem 'byebug'
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end
