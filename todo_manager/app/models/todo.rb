class Todo < ApplicationRecord
  validates :title, {presence: true}
  enum status_id: { unstarted: 0, working: 1, completed: 2 }, priority_id: { low: 0, middle: 1, high: 2 }
  paginates_per 10
end
