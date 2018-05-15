class User < ApplicationRecord
  validates :name, { presence: true, uniqueness: true }
  enum user_type: { admin: 0, normal: 1 }
  has_secure_password
  has_many :todos, dependent: :destroy
end
