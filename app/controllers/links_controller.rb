class LinksController < ApplicationController

  def new
    @link = Link.new
  end

  def create
    if params[:link][:long_url].present? && !params[:link][:short_url].present?
      link = Link.find_or_create_by(long_url: params[:link][:long_url])
      if link[:short_url].nil?
        link.shorten_url
        link.save!
        render plain: "Your link is CREATED: #{link.short_url}"
        return
      else
        render plain: "Your link ALREADY EXISTS and is #{link.short_url}"
        return
      end
    end

    if params[:link][:long_url].blank? && params[:link][:short_url].blank?
      render plain: "Failed to save - please enter your link"
      return
    end

    if params[:link][:long_url] && params[:link][:short_url]
      link = Link.find_or_create_by(
        long_url: params[:link][:long_url],
        short_url: params[:link][:short_url],
        )
      if link.valid?
        render plain: "Your CUSTOM link is created: #{link.short_url}"
        return
      else
        render plain: "Short URL needs to be UNIQUE. #{link.short_url} already exists."
        return
      end
    end
  end

  def redirect
    @link = Link.find_by(short_url: params[:short_url])
    redirect_to Addressable::URI.heuristic_parse(@link.long_url).to_s
  end

  # private

  # def link_params
  #   params.require(:link).permit(:long_url, :short_url)
  # end
end
