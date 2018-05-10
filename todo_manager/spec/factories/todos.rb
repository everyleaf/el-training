FactoryBot.define do
  factory :todo do
    title 'Sample title'
    content 'Sample content'
    deadline 1.day.since

    association :user, factory: :user, name: 'hoge', password: 'fuga'
  end
end
