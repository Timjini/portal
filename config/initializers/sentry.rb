Sentry.init do |config|
  config.dsn = ENV.fetch('SENTRY_KEY', nil)
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # Add data like request headers and IP for users,
  # see https://docs.sentry.io/platforms/ruby/data-management/data-collected/ for more info
  config.send_default_pii = true

  config.traces_sample_rate = 1.0
  # or control sampling dynamically
  config.traces_sampler = lambda do |sampling_context|
    sampling_context[:transaction_context]
    sampling_context[:parent_sampled]
    true
  end
end
