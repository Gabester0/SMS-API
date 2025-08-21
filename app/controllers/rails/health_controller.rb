# frozen_string_literal: true



module Rails
  class HealthController < ActionController::API
    skip_before_action :authenticate_user!, raise: false

    def show
      head :ok
    end
  end
end
