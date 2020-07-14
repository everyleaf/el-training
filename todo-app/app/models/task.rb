# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
  validates :due_date, presence: true
  validates :status, inclusion: { in: (0..3).to_a }
end
