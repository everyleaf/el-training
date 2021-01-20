# frozen_string_literal: true

FactoryBot.define do
  sequence :title do |i|
    "タスク#{format('%02d', i)}"
  end

  sequence :end_date do |i|
    Time.current + (i + 1).days
  end

  factory :task, class: Task do
    title { generate :title }
    # title { 'タスク' }
    detail { 'テスト' }
    end_date { generate :end_date }
    status { 'doing' }
    user
  end

  # 今後使いたいためメモとしてコメントアウト
  # trait :done do
  #   status { :done }
  #   completion_date { Time.current.yesterday }
  # end
end
