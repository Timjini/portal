# frozen_string_literal: true

FactoryBot.define do
  factory :plan do
    name { 'Basic Plan' }
    amount { 1 }
    day_of_month { 1 }
    day_of_week { 1 }
    interval { 1 }
    interval_unit { 'monthly' }
    currency { 'GBP' }
    status { 'active' }
    url { 'https://pay-sandbox.gocardless.com/BRT01KJ72NZYRSK6DSY0GVHTR873Q' }
  end
end


# name: "Basic Plan",
#  amount: 0.5e4,
#  day_of_month: 1,
#  day_of_week: 0,
#  month: 1,
#  interval: 1,
#  interval_unit: "month",
#  payment_reference: nil,
#  currency: "GBP",
#  status: "active",
#  redirect_url: nil,
#  count: nil,
#  scheme_notice_period: 3,
#  has_pending_update: false,
#  scheduled_to_pause: false,
#  instant_bank_pay: false,
#  links: nil,
#  organisation_details: nil,
#  fx: nil,
#  url: "https://pay-sandbox.gocardless.com/BRT01KJ72NZYRSK6DSY0GVHTR873Q",