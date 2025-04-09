# frozen_string_literal: true

FactoryBot.define do
  factory :athlete_profile do
    first_name { 'Kim' }
    last_name { 'Sting' }
    dob { 20.years.ago.to_date }
    address { '123 Main St' }
    city { 'New York' }
    association :user
  end
end
