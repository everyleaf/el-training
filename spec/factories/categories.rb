FactoryBot.define do
  factory :category do
    user { create(:user) }
    name { Category::DEFAULT_CREATED_CATEGORY }
  end
end
