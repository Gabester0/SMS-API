require 'redis'

begin
  url = ENV.fetch('REDIS_URL', 'redis://localhost:6379/1')
  Redis.current = Redis.new(url: url)
  Redis.current.ping
  Rails.logger.info "Successfully connected to Redis"
rescue Redis::CannotConnectError => error
  Rails.logger.error "Failed to connect to Redis: #{error.message}"
  Rails.logger.error "Redis URL: #{url}"
  raise
end
