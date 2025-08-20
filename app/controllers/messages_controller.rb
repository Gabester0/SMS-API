class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    messages = current_user.messages.order(created_at: :desc)
    render json: messages
  end

  def create
    message = current_user.messages.build(message_params)
    
    if message.save
      begin
        message.update(status: 'sending')
        twilio_response = TwilioService.new.send_sms(message)
        message.update(
          status: 'sent',
          twilio_sid: twilio_response.sid
        )
        render json: message, status: :created
      rescue => e
        message.update(status: 'failed')
        render json: { 
          errors: ["SMS sending failed: #{e.message}"]
        }, status: :unprocessable_entity
      end
    else
      render json: { errors: message.errors }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:to_phone_number, :content)
  end
end
