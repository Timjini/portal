# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

# gem 'pg'
gem 'mysql2', '~> 0.5.4'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.2'

# assets and JS bundling
gem 'cssbundling-rails'
gem 'esbuild-rails'
gem 'jsbundling-rails'
gem 'sprockets-rails'
gem 'tailwindcss-rails', '~> 3.0'

# Hotwire
gem 'stimulus-rails'
gem 'turbo-rails'

# json api here need to add fastAPI ?
gem 'active_model_serializers', '~> 0.10.2'
gem 'jbuilder'

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

# Authorization
gem 'cancancan'

# Error tracking
gem 'sentry-rails'
gem 'sentry-ruby'

# Utilities
gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
gem 'groupdate'
gem 'htmlbeautifier'
gem 'mailtrap', '~> 0.1.0'
gem 'rack-cors'
gem 'recurrence', '~> 1.3'
gem 'rqrcode'

# gem 'sendgrid-ruby'
gem 'brevo'
gem 'sib-api-v3-sdk'
gem 'will_paginate'

# caching
gem 'redis', '~> 5.0'
gem 'redis-namespace'
gem 'redis-rails'

# dev tools
gem 'guard-livereload', '~> 2.5', require: false
gem 'rubocop', '~> 1.67'
gem 'rubocop-performance', require: false
gem 'rubocop-rails', require: false

# compatibility on some platforms
gem 'bootsnap', require: false
gem 'ffi', '~> 1.9', '>= 1.9.10'
gem 'tzinfo-data', platforms: %i[windows jruby]

# Search
gem 'elasticsearch', '~> 8.8'
gem 'searchkick', '~> 5.5', '>= 5.5.2'

group :development, :test do
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'bundler-audit', require: false
  gem 'byebug'
  gem 'capybara'
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rack-mini-profiler'
  gem 'rspec-rails'
  gem 'ruby-lsp', '~> 0.26.1', require: false
  gem 'ruby-lsp-rails', require: false
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  gem 'web-console'
end
