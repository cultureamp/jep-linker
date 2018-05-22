class Link < ApplicationRecord
  before_validation { check_short_url }

  belongs_to :user

  def check_short_url
    unless self.short_url
      self.short_url = SecureRandom.urlsafe_base64(6)
    end
  end
end
