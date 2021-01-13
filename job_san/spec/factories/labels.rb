# frozen_string_literal: true

FactoryBot.define do
  factory :label, class: Label do
    name { Faker::JapaneseMedia::Naruto.character }
  end
end
