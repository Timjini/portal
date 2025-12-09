ActiveSupport::Notifications.subscribe('cache_read.active_support') do |name, start, finish, id, payload|
  if payload[:hit]
    Rails.logger.debug { "Cache HIT: #{payload[:key]}" }
  else
    Rails.logger.debug { "Cache MISS: #{payload[:key]}" }
  end
end
