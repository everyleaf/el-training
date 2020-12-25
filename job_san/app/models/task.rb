# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 255 }
  enum status: %i[todo doing done]
  enum priority: %i[low medium high]
end
