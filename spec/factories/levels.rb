# frozen_string_literal: true

FactoryBot.define do
  factory :level do
    title { 'Beginner' }
    degree { 1 }
    category { 1 }
    step { 1 }
  end
end
