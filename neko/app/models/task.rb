class Task < ApplicationRecord
  validates :name, presence: true
end
