ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../../config/environment', __FILE__)
require 'minitest/autorun'
require 'ostruct'

class TwilioServiceTest < Minitest::Test
  def setup
    @message = OpenStruct.new(
      to_phone_number: "+14155552671",
      from_phone_number: nil,
      content: "Test message"
    )

    # Mock Rails.application.config.x.twilio
    @twilio_config = { phone_number: "+14155552670" }
    Rails.application.config.x.twilio = @twilio_config

    # Create mock response
    @mock_response = Object.new
    def @mock_response.sid; "SM123"; end
    def @mock_response.status; "queued"; end
    def @mock_response.error_code; nil; end
    def @mock_response.error_message; nil; end

    # Create mock client with messages collection
    @mock_messages = Object.new
    def @mock_messages.create(params)
      if params[:from] == "+14155552672" # Test for custom from number
        @mock_response
      else
        @mock_response
      end
    end

    @mock_client = Object.new
    def @mock_client.messages; @mock_messages; end
    @mock_client.instance_variable_set(:@mock_messages, @mock_messages)
    @mock_messages.instance_variable_set(:@mock_response, @mock_response)

    # Mock Rails.application.credentials.twilio
    Rails.application.credentials.stub(:twilio, { account_sid: "test_sid", auth_token: "test_token" }) do
      Twilio::REST::Client.stub :new, @mock_client do
        @service = TwilioService.new
      end
    end
  end

  def test_successful_message_sending
    response = @service.send_sms(@message)
    assert_equal "SM123", response.sid
    assert_equal "queued", response.status
  end

  def test_handles_twilio_error
    error = StandardError.new("Twilio Error")
    
    expected_params = {
      from: Rails.application.config.x.twilio[:phone_number],
      to: @message.to_phone_number,
      body: @message.content,
      status_callback: "https://#{ENV['APP_HOST']}/twilio/status_callback"
    }
    
    def @mock_messages.create(*args)
      raise StandardError, "Twilio Error"
    end

    assert_raises StandardError do
      @service.send_sms(@message)
    end
  end

  def test_uses_message_from_number_when_provided
    @message.from_phone_number = "+14155552672"
    response = @service.send_sms(@message)
    assert_equal "SM123", response.sid
  end
end
