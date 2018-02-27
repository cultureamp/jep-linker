module Links
  module Builder
    def self.find_or_create(link_params, user)
      long_url = format_long_url(link_params[:long_url])
      link = Link.find_by(long_url: long_url, is_custom_url: false)
      link || create_new_link(link_params, long_url, user)
    end

    def self.create_new_link(link_params, long_url, user)
      if user
        user.links.create(short_url: link_params[:short_url], long_url: long_url)
      else
        Link.create(short_url: link_params[:short_url], long_url: long_url)
      end
    end

    def self.format_long_url(long_url)
      Addressable::URI.heuristic_parse(long_url.gsub(/www./, '')).to_s
    end

    def self.generate_short_url
      short_code = generate_short_code
      short_code = generate_short_code while Link.where(short_url: short_code).exists?
      short_code
    end

    def self.generate_short_code
      SecureRandom.urlsafe_base64(5).downcase!
    end
  end
end
