Rails.application.routes.default_url_options = {
  host: ENV.fetch('APP_HOST') { 'localhost' },
  port: ENV.fetch('PORT') { 3000 },
  protocol: ENV.fetch('PROTOCOL') { 'http' }
}
