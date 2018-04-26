FactoryBot.define do
  factory :todo do
    title 'Sample title'
    content 'Sample content'
    deadline 1.day.since
  end
end
