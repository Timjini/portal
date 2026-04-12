# frozen_string_literal: true

FactoryBot.define do # rubocop:disable Metrics/BlockLength
  factory :taster_session_booking do # rubocop:disable Metrics/BlockLength
    # Basic Info
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    athlete_full_name { "#{Faker::Name.first_name} #{last_name}" }
    email { Faker::Internet.unique.email }
    phone { Faker::PhoneNumber.cell_phone_in_e164 }
    role { %w[parent_user athlete_user].sample }
    birth_date { Faker::Date.birthday(min_age: 5, max_age: 18) }

    # Session Logistics
    taster_session_date { Faker::Date.between(from: 1.day.from_now, to: 14.days.from_now) }
    start_time { taster_session_date.to_datetime.change(hour: [16, 17, 18].sample) }
    location { ['Main Gym', 'Studio A', 'Outdoor Field'].sample }
    status { 'pending' }

    # Requirements
    registration_confirmation { true }
    policy_agreement { true }
    health_issues { [nil, 'Mild asthma', 'Nut allergy'].sample }

    # Emergency & Marketing
    emergency_contact_name { Faker::Name.name }
    emergency_contact_phone { Faker::PhoneNumber.cell_phone_in_e164 }
    referral_source { %w[Instagram Facebook Friend Website].sample }

    # Associations
    association :training_package
    # user_id { nil } #

    # Traits for different lifecycle states
    trait :confirmed do
      status { 'confirmed' }
    end

    trait :completed do
      status { 'completed' }
      internal_notes { 'Athlete showed great promise. Recommended Elite package.' }
    end

    trait :no_show do
      status { 'no_show' }
    end

    trait :with_reminder do
      reminder_sent_at { 1.day.ago }
    end

    extra { Faker::Json.shallow_json(width: 3) }
  end
end
