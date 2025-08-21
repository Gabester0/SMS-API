require 'redis'

redis_config = {
  url: ENV.fetch('REDIS_URL'),
  ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE },
  retry_count: 3,
  timeout: 1
}

begin
  Redis.current = Redis.new(redis_config)
  Redis.current.ping
  Rails.logger.info "Successfully connected to Redis"
rescue Redis::CannotConnectError => error
  Rails.logger.error "Failed to connect to Redis: #{error.message}"
  Rails.logger.error "Redis URL: #{ENV['REDIS_URL']}"
  raise
end
