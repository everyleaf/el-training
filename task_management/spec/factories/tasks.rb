FactoryBot.define do
  factory :task do
    title { 'English' }
    priority { 1 }
    status { 0 }
    due { '2020/07/01' }
    description { 'English' }
  end
end
