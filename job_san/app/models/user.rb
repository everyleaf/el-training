# frozen_string_literal: true

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :tasks, dependent: :delete_all
  validates :name, presence: true, length: { minimum: 1, maximum: 100 }
  validates :email, presence: true, length: { minimum: 1, maximum: 255 }, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 5, maximum: 255 }, allow_nil: true

  attr_accessor :remember_token

  has_secure_password

  def remember
    self.remember_token = new_token
    self.update(remember_digest: digest(remember_token))
  end

  # @param [Object] remember_token
  def authenticated?(token)
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  def forget
    update(remember_token: nil, remember_digest: nil)
  end

  private

  def digest(confidential_item)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(confidential_item, cost: cost)
  end

  def new_token
    SecureRandom.urlsafe_base64
  end
end
