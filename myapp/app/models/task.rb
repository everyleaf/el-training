# == Schema Information
#
# Table name: tasks
#
#  id                                           :bigint           not null, primary key
#  deleted_at                                   :datetime
#  description                                  :text(65535)      not null
#  expires_at                                   :datetime
#  priority({0: "high", 1: "middle", 2: "low"}) :integer          not null
#  status(["waiting", "doing", "completed"])    :integer          not null
#  title                                        :string(255)      not null
#  created_at                                   :datetime         not null
#  updated_at                                   :datetime         not null
#  user_id                                      :bigint           not null
#
# Indexes
#
#  index_tasks_on_user_id                            (user_id)
#  index_tasks_on_user_id_and_expires_at             (user_id,expires_at)
#  index_tasks_on_user_id_and_priority               (user_id,priority)
#  index_tasks_on_user_id_and_status                 (user_id,status)
#  index_tasks_on_user_id_and_status_and_expires_at  (user_id,status,expires_at)
#  index_tasks_on_user_id_and_status_and_priority    (user_id,status,priority)
#  index_tasks_on_user_id_and_title                  (user_id,title)
#
class Task < ApplicationRecord
  acts_as_paranoid
  belongs_to :user, optional: true
  enum priority: { high: 0, middle: 1, low: 2 }
  enum status: { waiting: 0, doing: 1, completed: 2 }
  PRIORITY_LIST = [%w[middle middle], %w[high high], %w[low low]]
  STATUS_LIST = [%w[waiting waiting], %w[doing doing], %w[completed completed]]
  SORT_TYPE = {
    :created_at_asc => 'created_at ASC',
    :created_at_desc => 'created_at DESC',
    :expires_at_asc => 'expires_at ASC',
    :expires_at_desc => 'expires_at DESC',
  }.freeze

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :priority, presence: true
  validates :status, presence: true
  validates :title, presence: true
  validates :user_id, presence: true

  scope :sort_by_keyword, ->(sort) { order(SORT_TYPE[sort.to_sym]) }

  class << self
    def sort_params_checker(sort)
      if sort.present? && SORT_TYPE.has_key?(sort.to_sym)
        return sort 
      else
        return 'created_at_asc'
      end
    end
  end
end
