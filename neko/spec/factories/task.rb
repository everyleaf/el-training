FactoryBot.define do
  factory :task, class: Task do
    sequence(:name) { Faker::Name.name }
    sequence(:description) { Faker::Lorem.sentence }
    sequence(:due_at) { Faker::Time.forward(days: 300) }
    sequence(:have_a_due) { Faker::Boolean.boolean }
    sequence(:status) { Status.all.sample }
  end
end
