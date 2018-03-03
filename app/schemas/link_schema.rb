require 'dry-validation'

LinkSchema = Dry::Validation.Form do
  configure do
    config.messages_file = 'app/transactions/errors.yml'
    config.namespace = :link

    def url?(value)
      /\A#{URI::regexp(%w(http https))}\z/.match(value)
    end

    def not_shortening_service?(value)
      begin
        url = URI.parse(value)
      rescue URI::InvalidURIError
        return false
      end
      !["goo.gl", "bit.ly"].include?(url.host)
    end

    def not_links?(value)
      value != "links"
    end
  end

  required(:long_url).filled(:str?, :url?, :not_shortening_service?)
  required(:short_url).maybe(:str?, :not_links?, max_size?: 50)
end
