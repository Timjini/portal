class UserChecklist < ApplicationRecord
  # belongs_to :user_level, optional: true
  belongs_to :check_list, optional: true
  belongs_to :user

  # Add a boolean field to track completion status
  attribute :completed, :boolean, default: false
end