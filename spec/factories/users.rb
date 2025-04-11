# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password123' }
    first_name { 'Test' }
    last_name { 'User' }
    role { 'athlete' }

    trait :parent do
      role { 'parent_user' }
    end

    trait :child do
      role { 'child_user' }
    end

    trait :coach do
      role { 'coach' }
    end

    trait :admin do
      role { 'admin' }
    end

    trait :with_athlete_profile do
      after(:create) do |user|
        create(:athlete_profile, user: user)
      end
    end
  end
end
