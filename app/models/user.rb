require 'securerandom'

class User < ApplicationRecord
  before_create :generate_api_token
  has_many :links

  def generate_api_token
    self.api_token = SecureRandom.uuid
  end

  # Include default devise modules. Others available are:
  # :confirmable  , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
