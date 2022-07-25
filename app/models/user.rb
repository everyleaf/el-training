class User < ApplicationRecord
  has_many :category, dependent: :destroy
end
