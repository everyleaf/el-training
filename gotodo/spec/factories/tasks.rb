FactoryBot.define do
  factory :task, class:Task do
    task_name { 'テスト' }
    detail { 'テスト' }
  end

    # 今後使いたいためメモとしてコメントアウト
    # trait :done do
    #   status { :done }
    #   completion_date { Time.current.yesterday }
    # end
end
