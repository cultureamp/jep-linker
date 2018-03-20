require 'json'
require 'pry'

class Api::LinksController < ApplicationController
  before_action :require_authentication

  def create
  end

  def index
      @links = current_user.links.all
      render json: @links
  end

  protected

  def require_authentication
    return true if authenticate
    render plain: "invalid api token (or something like that)", status: 401
  end

  def authenticate
    # authorization = request.headers["Authorization"]
    authenticate_with_http_token do |token|
      current_user = User.find_by(api_token: token)
      sign_in(current_user, store: false)
    end
  end
end
