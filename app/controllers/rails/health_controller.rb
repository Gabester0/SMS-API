# frozen_string_literal: true

module Rails
  class HealthController < ActionController::Base
    def show
      head :ok
    end
  end
end
