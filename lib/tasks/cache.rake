namespace :cache do
  desc 'Clear Redis cache'
  task clear: :environment do
    if Rails.cache.respond_to?(:clear)
      Rails.cache.clear
      puts 'Redis cache cleared'
    else
      puts "Current cache store doesn't support clear"
    end
  end

  desc 'Show cache stats'
  task stats: :environment do
    if defined?(Redis)
      redis = Redis.current
      info = redis.info
      puts 'Redis Stats:'
      puts "  Connected clients: #{info['connected_clients']}"
      puts "  Used memory: #{info['used_memory_human']}"
      puts "  Keyspace hits: #{info['keyspace_hits']}"
      puts "  Keyspace misses: #{info['keyspace_misses']}"
      puts "  Hit rate: #{(info['keyspace_hits'].to_f / (info['keyspace_hits'].to_i + info['keyspace_misses'].to_i) * 100).round(2)}%"
    else
      puts 'Redis not configured'
    end
  end
end
