class CheckList < ApplicationRecord
  belongs_to :level
  # has_many :user_checklists, dependent: :destroy
  has_one :user_checklists, dependent: :destroy
  has_many :user_levels, through: :user_checklists



  def checked_user_item(id)
    item = UserChecklist.find_by(check_list_id: self.id, user_id: id, completed: true)

    if item.present?
      return "checked"
    else
      return false
    end
    
  end

end
