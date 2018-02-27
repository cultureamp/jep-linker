class LinksController < ApplicationController
  before_action :authenticate_user!, only: :destroy
  before_action :set_links, only: %i[new create]

  def show
    @link = Link.find(params[:id])
  end

  def new
    @link = Link.new
  end

  def create
    @link = Links::Builder.find_or_create(link_params, current_user)
    if @link.valid?
      redirect_to @link
    else
      render 'new'
    end
  end

  def destroy
    Link.find(params[:id]).destroy
    redirect_to root_path
  end

  def forward
    @link = Link.find_by(short_url: params[:short_url])
    redirect_to @link.long_url
  end

  private

  def link_params
    params.require(:link).permit(:long_url, :short_url)
  end

  def set_links
    @links = user_signed_in? ? current_user.links : []
  end
end
