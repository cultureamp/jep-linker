module Links
  class Create
    step :format_long_url
    step :find_link

    def format_long_url(link_params)
      long_url = Addressable::URI.heuristic_parse(link_params[:long_url].gsub(/www./, '')).to_s
      Success(link_params.merge(long_url: long_url))
    end

    def find_link
      link = if user
        find_user_link(link_params[:short_url], long_url, user)
      else
        find_non_user_link(link_params[:short_url], long_url)
      end
    end

    private

    def find_user_link(short_url, long_url, user)
      short_url.downcase!
      return user.links.find_by(long_url: long_url, short_url: short_url) unless short_url.blank?
      user.links.find_by(long_url: long_url, is_custom_url: false)
    end

    def find_non_user_link(short_url, long_url)
      return Link.find_by(long_url: long_url, is_custom_url: false) if short_url.blank?
      nil
    end
  end
end
