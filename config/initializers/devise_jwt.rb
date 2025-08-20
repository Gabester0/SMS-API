Devise.setup do |config|
  config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.jwt_secret_key || 'your-secret-key'
    jwt.dispatch_requests = [
      ['POST', %r{^/users/sign_in$}]
    ]
    jwt.revocation_requests = [
      ['DELETE', %r{^/users/sign_out$}]
    ]
    jwt.expiration_time = 1.day.to_i
  end
end
