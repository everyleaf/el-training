FactoryBot.define do
  factory :category do
    name { '未分類' }
    user { create(:user) }
  end
end
