# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 30 }, uniqueness: true, email: true

  has_secure_password
end
