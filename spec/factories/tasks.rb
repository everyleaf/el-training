FactoryBot.define do
  factory :task do
    name { 'test task' }
    category { FactoryBot.create(:category) }
    description    { 'this is a test task' }
    start_date     { Time.zone.today }
    necessary_days { 3 }
    progress       { '未着手' }
    priority       { '低' }
  end
end
