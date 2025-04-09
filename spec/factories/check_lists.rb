# frozen_string_literal: true

FactoryBot.define do
  factory :check_list do
    title { 'My Checklist' }
    level { create(:level) }
  end
end
