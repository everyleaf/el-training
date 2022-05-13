class Task < ApplicationRecord
  validates :name,           presence: true
  validates :start_date,     presence: true
  validates :necessary_days, presence: true
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
end
