require 'pry'
class Link < ApplicationRecord
  before_validation :process_long_url, on: :create
  validates :short_url, :long_url, uniqueness: true

  def process_long_url
    self.long_url = Addressable::URI.heuristic_parse(long_url).to_s
  end

  def shorten_url
    self.short_url = id.to_i.to_s(16)
  end
end
