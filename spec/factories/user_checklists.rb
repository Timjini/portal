# frozen_string_literal: true

FactoryBot.define do
  factory :user_checklist do
    user_level_id { 1 }
    check_list_id { 1 }
    completed { true }
    title { 'check list item' }
    association :user
  end
end
