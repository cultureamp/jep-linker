class ShortUrl < ApplicationRecord
  belongs_to :user
  belongs_to :link
  validates_uniqueness_of :value, :link_id
end
