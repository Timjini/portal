class UserLevel < ApplicationRecord
  belongs_to :user
  belongs_to :level
  # has_many :check_lists, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  attr_accessor :level_degree

  def level_degree
    level.degree
  end

  # set status to completed

  enum status: { not_started: 'not_started', in_progress: 'in_progress', completed: 'completed' }
  validates :status, presence: true, inclusion: { in: %w[not_started in_progress completed] }
end
