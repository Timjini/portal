class UserLevel < ApplicationRecord
  belongs_to :user
  belongs_to :level
  has_many :check_lists, dependent: :destroy



  enum status: { not_started: 'not_started', in_progress: 'in_progress', completed: 'completed' }
  validates :status, presence: true, inclusion: { in: %w[not_started in_progress completed] }
end
