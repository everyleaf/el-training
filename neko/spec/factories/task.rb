FactoryBot.define do
  factory :task, class: Task do
    sequence(:name) { Faker::Name.name }
    sequence(:description) { Faker::Lorem.sentence }
  end
end
