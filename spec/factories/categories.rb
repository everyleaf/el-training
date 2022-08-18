FactoryBot.define do
  factory :category do
    user { create(:user) }
    name { Category::TASK_DEFAULT_BELONG_NAME }
  end
end
