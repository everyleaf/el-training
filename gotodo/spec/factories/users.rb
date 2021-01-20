# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'テストユーザ' }
    email { 'test@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
