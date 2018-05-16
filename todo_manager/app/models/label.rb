class Label < ApplicationRecord
  has_many :todo_to_labels
  has_many :todos, through: :todo_to_labels
end
