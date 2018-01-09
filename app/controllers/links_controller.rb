class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = find_or_create(link_params)
    if @link.valid?
      redirect_to @link
    else
      render 'new'
    end
  end

  def show
    @link = Link.find(params[:id])
  end

  def forward
    @link = Link.find_by(short_url: params[:short_url])
    redirect_to "http://#{@link.long_url}"
  end

  private

  def link_params
    params.require(:link).permit(:long_url, :short_url)
  end

  def find_or_create(link_params)
    link = Link.find_by(long_url: link_params[:long_url], is_custom_url: false)
    link || Link.create(link_params)
  end
end
