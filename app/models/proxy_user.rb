class ProxyUser < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { self.email = email.downcase }

  validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { maximum: 50 }

  has_secure_password
  validates :password, length: { minimum: 6 }
end
