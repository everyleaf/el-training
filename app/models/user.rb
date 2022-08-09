class User < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :tasks, through: :categories, dependent: :destroy

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name,     presence: true
  validates :password, presence: true,
                       length: { minimum: 8 },
                       allow_nil: true  # editフォームのパスワード欄を空欄でもupdate可能にする
  validates :email,    presence: true,
                       uniqueness: true,
                       format: { with: VALID_EMAIL_REGEX }

  before_save { self.email = email.downcase }
end
