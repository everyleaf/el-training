class Task < ApplicationRecord
  validates :name,           presence: true
  validates :start_date,     presence: true
  validates :necessary_days, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :progress,       presence: true
  validates :priority,       presence: true

  enum progress: {
    '未着手': 0,
    '実行中': 1,
    '完了': 2
  }

  enum priority: {
    '低': 0,
    '中': 1,
    '高': 2
  }

  scope :search_task, ->(name, option) {
    if name.blank?
      all
    elsif option == 'perfect_match'
      where(name:)
    else # partial_match
      where('name LIKE ?', "%#{name}%")
    end
  }
end
