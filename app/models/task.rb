class Task < ApplicationRecord
  DEAFULT_CATEGORY = '未分類'
  belongs_to :category, default: -> { Category.find_by(name: DEAFULT_CATEGORY) }
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

  scope :filter_from_checkbox, ->(params_is_blank, priority, progress) {
    if params_is_blank # indexページに遷移直後 or チェックボックスが空のとき
      all              # フィルタリングを行わない
    else
      where(priority:, progress:)
    end
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
