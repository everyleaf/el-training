class Task < ApplicationRecord
  validates :name,        presence: true
  validates :description, presence: true
  validates :start_date,  presence: true
  validates :progress,    presence: true
end
