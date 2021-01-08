# frozen_string_literal: true

FactoryBot.define do
  factory :task, class: Task do
    title { 'テスト' }
    detail { 'テスト' }
    end_date { Time.zone.today }
  end

  # 今後使いたいためメモとしてコメントアウト
  # trait :done do
  #   status { :done }
  #   completion_date { Time.current.yesterday }
  # end
end
