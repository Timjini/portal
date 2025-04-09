FactoryBot.define do
  factory :answer do
    content { 'No' }
    explination { Faker::Lorem.sentence }
    association :user
    association :question

    trait :positive do
      content { 'Yes' }
    end
  end
end
