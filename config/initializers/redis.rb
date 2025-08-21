require 'redis'
require 'connection_pool'

redis_config = {
  url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1'),
  ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE },
  reconnect_attempts: 3,
  error_handler: -> (method:, returning:, exception:) {
    Rails.logger.error "Redis error: #{exception.message}"
  }
}

Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) do
  Redis.new(redis_config)
end

Rails.application.config.cache_store = :redis_cache_store, redis_config.merge(
  pool_size: 5,
  pool_timeout: 5
)
