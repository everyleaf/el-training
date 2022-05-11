class Task < ApplicationRecord
  validates :name,           presence: true
  validates :start_date,     presence: true
  validates :necessary_days, presence: true
  validates :progress,       presence: true
  validates :priority,       presence: true
end
