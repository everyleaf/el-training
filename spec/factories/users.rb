FactoryBot.define do
  factory :user do
    name { 'test user' }
    email { 'factory@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
