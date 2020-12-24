FactoryBot.define do
  factory :task_a, class:Task do
    task_name { '買い物に行く' }
    detail { '卵、牛乳' }
  end

  factory :task_b, class:Task do
    task_name { '美容院に行く' }
    detail { 'ヘアサロン・ラクマ' }

    # 今後使いたいためメモとしてコメントアウト
    # trait :done do
    #   status { :done }
    #   completion_date { Time.current.yesterday }
    # end
  end
end
