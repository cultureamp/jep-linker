module Services
  class Url
    def self.find_or_create_unregistered_link(long_url:)
      addressable_url = set_url(url: long_url).to_s
      previous_link = Link.find_by(:long_url => addressable_url)
      generated_short_link = generate_short_link 

      return previous_link if previous_link.present?

      Link.create(long_url: addressable_url, short_url: generated_short_link)
    end

    def self.find_or_create_registered_link(long_url:, custom_url:, current_user:)
      addressable_url = set_url(url: long_url).to_s
      previous_user_link = current_user.links.find_by(:long_url => addressable_url)
      previous_user_link_has_custom_url = current_user.short_urls.find_by(value: custom_url).present?
      unregistered_link = Link.find_by(long_url: addressable_url)
      generated_short_link = generate_short_link 

      if unregistered_link.present?
        if custom_url.empty?
          ShortUrl.create(user_id: current_user.id, link_id: unregistered_link.id)
          unregistered_link
        else
          ShortUrl.create(user_id: current_user.id, link_id: unregistered_link.id, value: custom_url) 
          unregistered_link
        end
      else
        new_link = Link.create(long_url: addressable_url, short_url: generated_short_link)
        if custom_url.empty?
          ShortUrl.create!(user_id: current_user.id, link_id: new_link.id)
          new_link
        else
          ShortUrl.create!(user_id: current_user.id, link_id: new_link.id, value: custom_url)
          new_link
        end
      end
    end

    def self.set_url(url:)
      Addressable::URI.heuristic_parse(url)
    end

    def self.generate_short_link
      unique_id = Link.all.count + 1
      unique_id.to_s + SecureRandom.base64(6) 
    end
  end
end





