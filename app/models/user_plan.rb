# frozen_string_literal: true

class UserPlan < ApplicationRecord
  belongs_to :user
  belongs_to :plan
end
