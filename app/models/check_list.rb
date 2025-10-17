# frozen_string_literal: true

class CheckList < ApplicationRecord
  belongs_to :level
  has_many :user_checklists, dependent: :destroy
  has_many :user_levels, through: :user_checklists

  def checked_user_item(id)
    item = UserChecklist.find_by(check_list_id: self.id, user_id: id, completed: true)

    return 'checked' if item.present?

    false
  end

  def check_list_level
    level = self.level.degree
    level if level
  end
end
