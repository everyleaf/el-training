# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  deleted_at         :datetime
#  email              :string(255)      not null
#  encrypted_password :string(255)      not null
#  name               :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_name   (name)
#
FactoryBot.define do
  factory :user do
    sequence(:name) { |i| "name_#{i}" }
    encrypted_password { "098f6bcd4621d373cade4e832627b4f6" }
    email { "takasawa@rakuten.com" }
  end
end
