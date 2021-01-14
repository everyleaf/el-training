# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :detail, length: { maximum: 200 }

  enum status: { todo: 0, doing: 5, done: 9 }

  scope :task_search, (lambda do |search_params|
    title_like(search_params[:title])
      .status_is(search_params[:status])
      .sorted(search_params[:sort], search_params[:direction])
  end)
  scope :title_like, -> (title) { where('title LIKE ?', "%#{title}%") if title.present? }
  scope :status_is, -> (status) { where(status: status) if status.present? }
  scope :sorted, -> (sort, direction) { order("#{sort} #{direction}") if sort.present? && direction.present? }
end
