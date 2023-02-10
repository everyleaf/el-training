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
#  owner_id                                     :bigint           not null
#
# Indexes
#
#  index_tasks_on_owner_id                            (owner_id)
#  index_tasks_on_owner_id_and_expires_at             (owner_id,expires_at)
#  index_tasks_on_owner_id_and_priority               (owner_id,priority)
#  index_tasks_on_owner_id_and_status                 (owner_id,status)
#  index_tasks_on_owner_id_and_status_and_expires_at  (owner_id,status,expires_at)
#  index_tasks_on_owner_id_and_status_and_priority    (owner_id,status,priority)
#  index_tasks_on_owner_id_and_title                  (owner_id,title)
#
class Task < ApplicationRecord
  acts_as_paranoid
  enum priority: { high: 0, middle: 1, low: 2 }
  PRIORITY_LIST = [%w[middle middle], %w[high high], %w[low low]]
  STATUS_LIST = [%w[waiting waiting], %w[doing doing], %w[completed completed]]
end
