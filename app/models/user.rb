class User < ApplicationRecord
  has_many :tracks
  has_many :urls, through: :tracks
  before_save { self.email = email.downcase }
  validates :name , presence: true , length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email , presence: true , length: {maximum: 255} , format: {with: VALID_EMAIL_REGEX} , uniqueness: {case_sensitive: false}
  has_secure_password
end
