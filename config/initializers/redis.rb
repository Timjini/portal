redis_config = {
  url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1'),
  reconnect_attempts: 3,
  timeout: 5,
  connect_timeout: 5,
  read_timeout: 5,
  write_timeout: 5
}
