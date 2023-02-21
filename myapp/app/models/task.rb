# == Schema Information
#
# Table name: tasks
#
#  id                                           :bigint           not null, primary key
#  deleted_at                                   :datetime
#  description                                  :text(65535)      not null
#  expires_at                                   :datetime
#  priority({0: "high", 1: "middle", 2: "low"}) :integer          not null
#  status(["waiting", "doing", "completed"])    :string(255)      not null
#  title                                        :string(255)      not null
#  created_at                                   :datetime         not null
#  updated_at                                   :datetime         not null
#  user_id                                     :bigint           not null
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
  enum priority: { high: 0, middle: 1, low: 2 }
  enum status: { waiting: 0, doing: 1, completed: 2 }
  PRIORITY_LIST = [%w[middle middle], %w[high high], %w[low low]]
  STATUS_LIST = [%w[waiting waiting], %w[doing doing], %w[completed completed]]

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :priority, presence: true
  validates :status, presence: true
  validates :title, presence: true
  validates :user_id, presence: true

  has_many: users
end
