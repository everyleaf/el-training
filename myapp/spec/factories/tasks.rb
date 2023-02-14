FactoryBot.define do
  factory :task do
    sequence(:title) { |i| "task_name_#{i}" }
    expires_at { Time.now + 1.week }
    priority { %w[low middle high].sample }
    status { %w[waiting doing completed].sample }
    sequence(:description) { |i| "タスク説明文_#{i}" }
    sequence(:owner_id) {|i| i}
  end
end