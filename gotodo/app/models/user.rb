class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }

  has_secure_password
end
