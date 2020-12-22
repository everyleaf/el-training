# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, presence: true
  enum status: %i[todo doing done]
  enum priority: %i[low medium high]
end
