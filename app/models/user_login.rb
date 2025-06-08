class UserLogin < ApplicationRecord
  belongs_to :user

  scope :today, -> { where(login_at: Time.current.beginning_of_day..Time.current.end_of_day) }
end
