class Level < ApplicationRecord
  has_many :check_lists
  has_many :user_levels
end