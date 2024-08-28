FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "ThisIsTitle#{n}" }
    sequence(:description) { |n| "ThisIsDescription#{n}" }

    # title { 'ThisIsTitle1' }
    # description { 'ThisIsDescription1' }
  end

end
