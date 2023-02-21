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
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :task do
    sequence(:title) { |i| "task_name_#{i}" }
    expires_at { 1.week.since }
    priority { %w[low middle high].sample }
    status { %w[waiting doing completed].sample }
    sequence(:description) { |i| "タスク説明文_#{i}" }
    sequence(:user_id) { |i| i }
  end
end
