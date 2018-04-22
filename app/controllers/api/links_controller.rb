class Api::LinksController < ApplicationController
  before_action :authenticate_user

  def index
    @links = Link.all
  end

  private

  def authenticate_user
    user = authenticate_with_http_token do |token|
      User.find_by(token: token)
    end

    unless user
      render json: { error: "Unauthenticated." }, status: 401
      false
    end
  end
end
