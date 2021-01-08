# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    id { SecureRandom.uuid }
    name { Faker::JapaneseMedia::OnePiece.character }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    role_type { 'member' }

    trait :with_admin do
      role_type { 'admin' }
    end
  end
end
