# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user

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
  scope :sorted, (lambda do |sort, direction|
    sort_list = ['title', 'detail', 'end_date', 'status', 'created_at', 'edited_at']
    sort = sort_list.include?(sort) ? sort : nil
    direction_list = ['asc', 'desc']
    direction = direction_list.include?(direction) ? direction : nil
    sort.present? && direction.present? ? order("#{sort} #{direction}, id desc") : order('id desc')
  end)
end
