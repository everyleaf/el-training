FactoryBot.define do
  factory :user do
    name { 'test user' }
    email { 'user_0@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    activated { true }
    activated_at { Time.zone.now }
  end
end
