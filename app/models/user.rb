class User < ApplicationRecord
  validates :name,  presence: true
  VALID_EMAIL_REGEX = VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX }
  has_secure_password
end
