require 'action_cable/subscription_adapter/redis'

# Configure Action Cable Redis connection
ActionCable.server.config.cable = {
  'adapter' => 'redis',
  'url' => ENV.fetch('REDIS_URL', 'redis://localhost:6379/1'),
  'ssl_params' => { verify_mode: 0 }
}

# Configure Action Cable allowed request origins
Rails.application.config.action_cable.allowed_request_origins = [
  'https://sms-messenger.netlify.app',
  /https:\/\/sms-messenger\.netlify\.app.*/
]

# Configure Action Cable URL
Rails.application.config.action_cable.url = ENV.fetch('ACTION_CABLE_URL', 'wss://sms-api-production-b599.up.railway.app/cable')

# Disable request forgery protection for WebSocket requests
Rails.application.config.action_cable.disable_request_forgery_protection = true
