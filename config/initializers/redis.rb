require 'redis'

redis_config = {
  url: ENV.fetch('REDIS_URL'),
  ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE },
  reconnect_attempts: 3,
  reconnect_delay: 0.5,
  reconnect_delay_max: 2.0
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
