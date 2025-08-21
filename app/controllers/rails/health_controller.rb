# frozen_string_literal: true


module Rails
  class HealthController < ActionController::API
    def show
      head :ok
    end
  end
end
