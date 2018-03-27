class Link < ApplicationRecord
  has_many :short_links
  has_many :users, through: :short_links
  validates_uniqueness_of  :long_url, :short_url
  validates_presence_of :short_url

  def to_param
    short_url
  end
end
