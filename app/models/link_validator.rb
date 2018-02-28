class LinkValidator < ActiveModel::EachValidator

  def self.link_valid?(link)
    invalid_url_elements = [
      " ",
      "bit.ly",
      "goo.gl",
    ]
    invalid_url_elements.any? { |url| /#{url}/ =~ link }
  end
end
