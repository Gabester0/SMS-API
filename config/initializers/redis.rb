require 'redis'

$redis = Redis.new(url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1'))

begin
  $redis.ping
  Rails.logger.info "Successfully connected to Redis"
rescue Redis::CannotConnectError => error
  Rails.logger.error "Failed to connect to Redis: #{error.message}"
  Rails.logger.error "Redis URL: #{ENV['REDIS_URL']}"
  raise
end
