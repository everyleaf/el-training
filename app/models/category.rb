class Category < ApplicationRecord
  has_many :task, dependent: :restrict_with_exception
  validates :name, presence: true
end
