# frozen_string_literal: true

FactoryBot.define do
  factory :training_package do
    name { '1 session a week' }
    description { '' }
    features { ['Access to group training', 'Weekly guidance and support'] }
    price { 240 }
    duration_in_days { 30 }
    package_type { 'group_training' }
    training_type { 'group_training' }
    duration { 'month' }
    status { 'active' }
    start_date { '2026-04-01' }
    ending_date { '2026-05-01' }
  end
end
