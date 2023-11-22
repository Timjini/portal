class CheckList < ApplicationRecord
  belongs_to :level
  has_many :user_checklists, dependent: :destroy
end
