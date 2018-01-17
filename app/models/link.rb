class Link < ApplicationRecord
  validates :short_url, uniqueness: true
  #validates :long_url, url: true

  def shorten_url
    self.short_url = id.to_i.to_s(16)
  end
end





