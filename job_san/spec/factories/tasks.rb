# frozen_string_literal: true

FactoryBot.define do
  factory :task, class: Task do
    name { 'タスク名' }
    description { 'タスクの説明' }
    association :user
  end
end
