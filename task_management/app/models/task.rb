class Task < ApplicationRecord
  enum priority: { low: 0, middle: 1, high: 2 }
  enum status: { waiting: 0, working: 1, completed: 2 }

  validates :title, presence: true, length: { maximum: 20 }
  validates :status, presence: true
  validates :priority, presence: true
  validate :due_valid?

  private

  def due_valid?
    if due.nil? && due_before_type_cast.present?
      errors.add(:due, I18n.t('errors.message.invalid_date'))
    end
  end
end
