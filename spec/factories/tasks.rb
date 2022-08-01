FactoryBot.define do
  factory :task do
    name { 'test task' }
    category_id { FactoryBot.create(:category).id }
    description    { 'this is a test task' }
    start_date     { Time.zone.today }
    necessary_days { 3 }
    progress       { '未着手' }
    priority       { '低' }
  end
end
