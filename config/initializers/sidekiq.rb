# frozen_string_literal: true

# # frozen_string_literal: true

# require 'sidekiq'
# require 'sidekiq-cron'
# require 'yaml'

# schedule_file = 'config/sidekiq.yml'

# if File.exist?(schedule_file) && Sidekiq.server?
#   yaml_content = YAML.load_file(schedule_file)
#   schedule = yaml_content['scheduled'] # Match the key in YAML file
#   Sidekiq::Cron::Job.load_from_hash(schedule) if schedule
# end

# Sidekiq.configure_server do |config|
#   config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
# end

# Sidekiq.configure_client do |config|
#   config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
# end
