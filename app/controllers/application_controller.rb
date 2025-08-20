class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  def render_jsonapi_response(resource)
    if resource.errors.empty?
      render json: resource
    else
      render json: { errors: resource.errors }, status: :unprocessable_entity
    end
  end
end
