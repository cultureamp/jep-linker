module Links
  module Builder
    def self.build_link(link_params, user)
      long_url = format_long_url(link_params[:long_url])
      link = user ? find_user_link(link_params[:short_url], long_url, user) : find_non_user_link(link_params[:short_url], long_url)
      link || create_new_link(link_params[:short_url], long_url, user)
    end

    def self.find_user_link(short_url, long_url, user)
      return user.links.find_by(long_url: long_url, short_url: short_url) unless short_url.blank?
      user.links.find_by(long_url: long_url, is_custom_url: false)
    end

    def self.find_non_user_link(short_url, long_url)
      return Link.find_by(long_url: long_url, is_custom_url: false) if short_url.blank?
      nil
    end

    def self.create_new_link(short_url, long_url, user)
      if user
        user.links.create(short_url: short_url, long_url: long_url)
      else
        Link.create(short_url: short_url, long_url: long_url)
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
