Rails.application.config.x.twilio = {
  account_sid: Rails.application.credentials.twilio&.account_sid,
  auth_token: Rails.application.credentials.twilio&.auth_token,
  phone_number: Rails.application.credentials.twilio&.phone_number || '+15005550006'
}
