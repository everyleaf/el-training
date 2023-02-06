# == Schema Information
#
# Table name: tasks
#
#  id                                           :bigint           not null, primary key
#  deleted_at                                   :datetime
#  description                                  :text(65535)      not null
#  expires_at                                   :datetime
#  priority({1: "high", 2: "middle", 3: "low"}) :integer          not null
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
end
