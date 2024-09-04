FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "ThisIsTitle#{n}" }
    sequence(:description) { |n| "ThisIsDescription#{n}" }
    due_date_at { '2024/08/31' }
    status { Constants::STATUS_NOT_STARTED }
  end

end
