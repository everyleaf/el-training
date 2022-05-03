class Task < ApplicationRecord
  validates :task_name,     presence: true
  validates :abstract_text, presence: true
  # validates :start_date,    presence: true
  validates :status,        presence: true
end
