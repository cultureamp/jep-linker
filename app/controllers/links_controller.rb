class LinksController < ApplicationController

  def new
    @link = Link.new
  end

  def show
    @link = Link.find(params[:id])
  end

  def create
    long_url = params[:link][:long_url]
    short_url = params[:link][:short_url]
    if long_url.blank? && short_url.blank?
      render plain: "Failed to save - please enter your link"
      return
    end

    if short_url.blank?
      link = Link.find_by(long_url: long_url)
      if link
        render plain: "Your link ALREADY EXISTS and is #{link.short_url}"
        return
      end

      @link = Link.new(long_url: long_url)
      if @link.save
        @link.shorten_url
        @link.save!
        render plain: "Your link is CREATED: #{@link.short_url}"
        return
      else
        flash.now[:alert] = "Your link could not be saved"
        render :new
        return
      end
    end

    if long_url && short_url
      @link = Link.new(long_url: long_url, short_url: short_url)
      if @link.save
        flash[:notice] = "Your link was saved successfully"
        redirect_to @link
      else
        flash.now[:alert] = "Your link could not be saved"
        render :new
      end
    end
  end

  private

  def redirect
    @link = Link.find_by(short_url: params[:short_url])
    redirect_to "http://#{@link.long_url}"
  end
end
