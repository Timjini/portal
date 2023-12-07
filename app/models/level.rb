class Level < ApplicationRecord
  has_many :check_lists , dependent: :destroy
  has_many :user_levels , dependent: :destroy
end