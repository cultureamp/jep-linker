require 'dry/transaction'

module Links
  class Format
    include Dry::Transaction

    step :long_url_downcase
    step :long_url_remove_www
    step :long_url_add_http
    step :short_url_downcase
    step :validate

    def long_url_downcase(link_params)
      long_url = link_params[:long_url]
      if long_url.blank?
        Failure(["URL can't be blank"])
      else
        Success(link_params.merge(long_url: long_url.strip.downcase))
      end
    end

    def long_url_remove_www(link_params)
      long_url = link_params[:long_url].gsub(/www./, '')
      Success(link_params.merge(long_url: long_url))
    end

    def long_url_add_http(link_params)
      long_url = Addressable::URI.heuristic_parse(link_params[:long_url]).to_s
      Success(link_params.merge(long_url: long_url))
    end

    def short_url_downcase(link_params)
      short_url = link_params[:short_url]
      short_url.downcase! unless short_url.blank?
      Success(link_params.merge(short_url: short_url))
    end

    def validate(link_params)
      validation = LinkSchema.(link_params)
      if validation.success?
        Success(link_params)
      else
        Failure(validation.errors)
      end
    end
  end
end
