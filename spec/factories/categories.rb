FactoryBot.define do
  factory :category do
    name { '未分類' }
    user_id { FactoryBot.create(:user).id }
  end
end
