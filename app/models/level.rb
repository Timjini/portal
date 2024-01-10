class Level < ApplicationRecord
  has_many :check_lists , dependent: :destroy
  has_one :user_levels , dependent: :destroy
  


  enum degree: { beginner: 0, intermediate: 1, advanced: 2, expert: 3 , master: 4 }
  enum category: { information_management: 0, technical_ability: 1, physical_strength: 2, condition: 3, agility:4}


end