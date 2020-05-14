FactoryBot.define do
  factory :status, class: Status do
    factory :not_proceed do
      name { '未着手' }
      phase { 0 }
    end

    factory :in_progress do
      name { '着手中' }
      phase { 1 }
    end

    factory :done do
      name { '完了' }
      phase { 2 }
    end
  end
end
