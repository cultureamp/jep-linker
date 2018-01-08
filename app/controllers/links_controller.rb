class LinksController < ApplicationController
  include Services
  def index
  end

  def show
    @link = Link.find(params[:id])
  end

  def create
    empty = Services::Url.is_empty?(long_url: params[:long_url])
    if empty
      render plain: "Please enter your link"
    else
      @link = Services::Url.find_or_create(long_url: params[:long_url])
      @shortened_link = "Your short link is #{@link.short_url}"
      redirect_to link_path(@link) 
      flash[:notice] = "Short link successfully created"
    end
  end
end
