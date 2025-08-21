# frozen_string_literal: true


module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      token = request.params[:token]
      return reject_unauthorized_connection unless token

      begin
        # Use the same JWT decode logic as your API (Devise/JWT)
        payload = Warden::JWTAuth::TokenDecoder.new.call(token)
        user = User.find(payload['sub'])
        user || reject_unauthorized_connection
      rescue => e
        Rails.logger.error "ActionCable JWT error: \\#{e}"
        reject_unauthorized_connection
      end
    end
  end
end
