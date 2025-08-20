class TwilioWebhooksController < ActionController::API
  before_action :verify_twilio_request, only: :status_callback

  def status_callback
    message = Message.find_by(twilio_sid: params[:MessageSid])
    
    if message
      message.update(status: params[:MessageStatus])
      Rails.logger.info "Message #{message.twilio_sid} status updated to: #{params[:MessageStatus]}"
    else
      Rails.logger.error "Message not found for SID: #{params[:MessageSid]}"
    end

    head :ok
  end

  private

  def verify_twilio_request
    validator = Twilio::Security::RequestValidator.new(Rails.application.credentials.twilio[:auth_token])
    url = request.original_url
    params = request.request_parameters
    signature = request.headers['HTTP_X_TWILIO_SIGNATURE']

    unless validator.validate(url, params, signature)
      Rails.logger.error "Invalid Twilio request signature"
      head :forbidden
    end
  end
end
