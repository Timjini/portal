class Level < ApplicationRecord
  has_many :check_lists , dependent: :destroy
  has_many :user_levels , dependent: :destroy


  enum degree: { beginner: 0, intermediate: 1, advanced: 2, expert: 3 , master: 4 }

end