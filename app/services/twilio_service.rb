class TwilioService
  def initialize
    @client = Twilio::REST::Client.new(
      Rails.application.credentials.twilio[:account_sid],
      Rails.application.credentials.twilio[:auth_token]
    )
  end

  def send_sms(message)
    Rails.logger.info "Attempting to send SMS via Twilio..."
    Rails.logger.info "From: #{message.from_phone_number}"
    Rails.logger.info "To: #{message.to_phone_number}"
    Rails.logger.info "Content length: #{message.content.length} characters"
    
    response = @client.messages.create(
      from: message.from_phone_number || Rails.application.config.x.twilio[:phone_number],
      to: message.to_phone_number,
      body: message.content
    )
    
    Rails.logger.info "Message SID: #{response.sid}"
    Rails.logger.info "Message Status: #{response.status}"
    
    # Log error details only if they exist
    if response.error_code || response.error_message
      Rails.logger.error "Error Code: #{response.error_code}"
      Rails.logger.error "Error Message: #{response.error_message}"
    end
    
    response
  rescue Twilio::REST::RestError => e
    Rails.logger.error "Twilio Error: #{e.message}"
    Rails.logger.error "Error Code: #{e.code}"
    Rails.logger.error "Error More Info: #{e.more_info}"
    Rails.logger.error "Full Error: #{e.inspect}"
    raise
  end
end
