require 'dry/transaction'

module Links
  class Validate
    include Dry::Transaction

    OTHER_SHORTENERS = ["goo.gl", "bit.ly"].freeze
    LONG_URL_REGEX = /\A#{URI::regexp(%w(http https))}\z/

    step :long_url_presence
    step :long_url_valid_format
    step :long_url_shortening_service
    step :short_url_length
    step :short_url_format
    step :short_url_downcase

    def long_url_presence(link_params)
      Success(link_params) unless link_params[:long_url].blank?
      Failure(error: "URL can't be blank")
    end

    def long_url_valid_format(link_params)
      if link_params[:long_url].match?(LONG_URL_REGEX)
        Success(link_params)
      else
        Failure(error: "Invalid URL format")
      end
    end

    def long_url_shortening_service
      return Failure(error: "Shortening service not allowed") if shortening_service?(link_params[:long_url])
      Success(link_params)
    end

    def short_url_length(link_params)
      return Success(link_params) if link_params[:short_url].count < 51
      Failure(error: "Custom URL is too long")
    end

    def short_url_format(link_params)
      return Success(link_params) unless link_params[:short_url].casecmp("links")
      Failure(error: "Custom URL cannot be 'links'")
    end

    def short_url_downcase(link_params)
      short_url = link_params[:short_url]
      short_url.downcase! unless short_url.blank?
      Success(link_params.merge(short_url: short_url))
    end

    private

    def shortening_service?(long_url)
      begin
        url = URI.parse(long_url)
      rescue URI::InvalidURIError
        return false
      end
      OTHER_SHORTENERS.include?(url.host)
    end
  end
end
