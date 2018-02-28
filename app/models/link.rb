class Link < ApplicationRecord
  validates :short_url, :long_url, uniqueness: true

  def shorten_url
    self.short_url = id.to_i.to_s(16)
  end
end
