# frozen_string_literal: true

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :tasks, dependent: :delete_all
  validates :name, presence: true, length: { minimum: 1, maximum: 100 }
  validates :email, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 255 }
  validates :password, presence: true, length: { minimum: 5, maximum: 255 }

  has_secure_password
end
