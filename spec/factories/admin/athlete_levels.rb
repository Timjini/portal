# frozen_string_literal: true

FactoryBot.define do
  factory :admin_athlete_level, class: 'Admin::AthleteLevel' do
    name { 'MyString' }
    position { 1 }
    description { 'MyText' }
    min_age { 1 }
    max_age { 1 }
    color { 'MyString' }
    active { false }
  end
end
