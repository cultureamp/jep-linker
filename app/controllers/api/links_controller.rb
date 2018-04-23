class Api::LinksController < ApplicationController
  before_action :authenticate_user

  def index
    @links = @user.links.all
  end

  def create
    @link = @user.links.create(link_params)
    render "show"
  end

  private

  def link_params
    params.require(:link).permit(:long_url, :short_url)
  end

  def authenticate_user
    @user = authenticate_with_http_token do |token|
      User.find_by(token: token)
    end

    unless @user
      render json: { error: "Unauthenticated." }, status: 401
      false
    end
  end
end
