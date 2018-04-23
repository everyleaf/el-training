class Todo < ApplicationRecord
  validates :title, {presence: true}
end
