# frozen_string_literal: true

class UserLogin < ApplicationRecord
  belongs_to :user

  scope :today, -> { where(login_at: Time.current.all_day) }
end
