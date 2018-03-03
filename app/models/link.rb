class Link < ApplicationRecord
  before_validation :build_short_url
  before_validation { long_url.downcase! }

  belongs_to :user, optional: true

  validate :not_a_shortening_service
  validates :long_url,
            format: { with: /\A#{URI::regexp(%w(http https))}\z/,
                      message: "Invalid URL format" },
            presence: true
  validates :short_url,
            uniqueness: true,
            length: { maximum: 20, minimum: 1 },
            presence: true,
            format: { without: /\Alinks\z/ }

  private

  def build_short_url
    if short_url.blank?
      self.short_url = generate_short_url
    else
      self.is_custom_url = true
      short_url.downcase!
    end
  end

  def generate_short_url
    short_code = generate_short_code
    short_code = generate_short_code while Link.where(short_url: short_code).exists?
    short_code
  end

  def generate_short_code
    SecureRandom.urlsafe_base64(5).downcase!
  end

  def not_a_shortening_service
    if Links::Validation.shortening_service?(long_url)
      errors.add(:long_url_error, "- shortening service not allowed in long URL")
    end
  end
end
