# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :tasks, dependent: :destroy

  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 30 }, uniqueness: true, email: true

  scope :users_with_tasks_count, (lambda do
    left_outer_joins(:tasks)
      .select(Arel.sql('users.*, COUNT(tasks.id) AS count_all'))
      .group('users.id')
  end)

  scope :sorted, (lambda do |params|
    sort_hash = {
      'name' => 'users.name',
      'email' => 'users.email',
      'tasks_count' => 'count_all',
      'created_at' => 'users.created_at',
      'updated_at' => 'users.updated_at',
    }
    sort = sort_hash[params[:sort]]
    direction_list = %w[asc desc]
    direction = direction_list.include?(params[:direction]) ? params[:direction] : nil
    sort.present? && direction.present? ? order("#{sort} #{direction}, users.id desc") : order('users.id desc')
  end)
end
