# frozen_string_literal: true

QUERY_LOGGER = if Rails.env.local?
                 ActiveSupport::Logger.new($stdout)
               else
                 ActiveSupport::Logger.new(Rails.root.join('log/query_errors.log'))
               end

QUERY_LOGGER.formatter = proc do |severity, datetime, progname, msg| # rubocop:disable Lint/UnusedBlockArgument
  "#{datetime}: #{severity} - #{msg}\n"
end
