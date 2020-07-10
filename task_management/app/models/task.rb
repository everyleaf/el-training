class Task < ApplicationRecord
  enum priority: { low: 0, middle: 1, high: 2 }
  enum status: { waiting: 0, working: 1, completed: 2 }

  validates :title, presence: true, length: { maximum: 20 }
  validates :status, presence: true
  validates :priority, presence: true
  validate :due_valid?

  def self.search(search_params)
    title_like(search_params[:title]).
      status_is(search_params[:status]).
      order("#{search_params[:sort_column]} #{search_params[:sort_direction]}")
  end

  scope :title_like, -> (title) {
    where('title LIKE ?', "%#{sanitize_sql_like(title)}%") if title.present?
  }
  scope :status_is, -> (status) { where(status: status) if status.present? }

  private

  def due_valid?
    if due.nil? && due_before_type_cast.present?
      errors.add(:due, I18n.t('errors.message.invalid_date'))
    end
  end
end
