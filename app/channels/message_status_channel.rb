class MessageStatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from "message_status_#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end
