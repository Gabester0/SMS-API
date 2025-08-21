Rails.application.config.x.twilio = {
  account_sid: ENV['TWILIO_ACCOUNT_SID'] || Rails.application.credentials.twilio&.account_sid,
  auth_token: ENV['TWILIO_AUTH_TOKEN'] || Rails.application.credentials.twilio&.auth_token,
  phone_number: ENV['TWILIO_PHONE_NUMBER'] || Rails.application.credentials.twilio&.phone_number || '+15005550006'
}
