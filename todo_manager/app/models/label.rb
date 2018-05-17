class Label < ApplicationRecord
  validates :name, { presence: true, uniqueness: true }
  has_many :todo_to_labels
  has_many :todos, through: :todo_to_labels
end
