class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    # Only return messages for the current user
    dummy_messages = [
      {
        id: 1,
        content: "Hello from SMS API",
        phone_number: "+1234567890",
        status: "delivered",
        created_at: Time.current,
        user_id: current_user.id
      },
      {
        id: 2,
        content: "This is a test message",
        phone_number: "+9876543210",
        status: "pending",
        created_at: Time.current,
        user_id: current_user.id
      }
    ]

    render json: dummy_messages
  end

  def create
    # Simulate receiving message data with user association
    dummy_response = {
      id: 3,
      content: params[:content] || "New message",
      phone_number: params[:phone_number] || "+1122334455",
      status: "pending",
      created_at: Time.current,
      user_id: current_user.id
    }

    render json: dummy_response, status: :created
  end
end
