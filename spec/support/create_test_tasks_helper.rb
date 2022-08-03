module CreateTestTasksSupport
  def create_random_tasks_num(num)
    today = Time.zone.today
    # テスト用データの作成
    num.times do |n|
      name = "test_task_#{n}"
      start_date = rand(today..(today + 365))
      necessary_days = rand(1..50)
      priority = rand(0..2)
      progress = rand(0..2)

      create(:task, name:,
                    start_date:,
                    necessary_days:,
                    priority:,
                    progress:)
    end
  end
end

RSpec.configure do |config|
  config.include CreateTestTasksSupport
end
