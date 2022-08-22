FactoryBot.define do
  factory :task_not_started, class: Task do
    sequence(:title)    { |n| "テスト#{n}" }
    sequence(:content)  { |n| "こちらはテスト#{n}の内容です。テストテストテストテストテストテストテスト" }
    user_id             { 1 }
    status              { '1' }
    label               { 'テスト' }
  end
end
