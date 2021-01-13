# frozen_string_literal: true

FactoryBot.define do
  factory :label, class: Label do
    name { SecureRandom.uuid }
  end
end
