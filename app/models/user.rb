class User < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_secure_password

  VALID_EMAIL_REGEX = VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  validates :name,     presence: true
  validates :password, presence: true, 
                       length: { minimum: 8 }
  validates :email,    presence: true,
                       uniqueness: true,
                       format: { with: VALID_EMAIL_REGEX }

  before_save { self.email = email.downcase }
end
