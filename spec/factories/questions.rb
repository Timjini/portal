# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    sequence(:content) { |n| "Question #{n}" }
    question_type { 'radio' }
    options { %w[Yes No] }
    position { 1 }
    association :questionnaire
    illness_tag { nil } # Set this for illness-related questions

    trait :with_illness_tag do
      illness_tag { Faker::Lorem.words(number: 2).join(' ') }
    end
  end
end
