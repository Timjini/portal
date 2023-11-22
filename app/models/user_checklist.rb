class UserChecklist < ApplicationRecord
  belongs_to :user_level
  belongs_to :check_list
  belongs_to :user

  # Add a boolean field to track completion status
  attribute :completed, :boolean, default: false
end