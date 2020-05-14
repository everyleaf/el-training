class Task < ApplicationRecord
  validates :name, presence: true
  belongs_to :status

  def self.search(search)
    return Task.all unless search

    Task.where(status_id: search)
  end
end
