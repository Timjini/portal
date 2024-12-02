# frozen_string_literal: true

class UserLevel < ApplicationRecord
  belongs_to :user
  belongs_to :level
  # has_many :check_lists, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  attr_accessor :level_degree

  delegate :degree, to: :level, prefix: true

  def progress
    # Assuming self.count returns the count value
    count = self.count.to_f
    total = 125.0

    # Calculate the percentage
    (count / total) * 100
  end

  # set status to completed

  enum :status, { not_started: 'not_started', in_progress: 'in_progress', completed: 'completed' }
  validates :status, presence: true, inclusion: { in: %w[not_started in_progress completed] }
end
