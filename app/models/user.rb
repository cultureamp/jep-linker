class User < ApplicationRecord
  before_save { self.token = SecureRandom.urlsafe_base64(6)}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :links
end
