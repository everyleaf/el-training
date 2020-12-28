# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { minimum: 3, maximum: 20 }
  # validates :email
  validates :password, presence: true, length: { minimum: 5, maximum: 255 }
end
