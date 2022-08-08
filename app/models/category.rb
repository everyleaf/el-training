class Category < ApplicationRecord
  belongs_to :user
  has_many :task, dependent: :restrict_with_error
  validates :name, presence: true, uniqueness: { scope: :user }
end
