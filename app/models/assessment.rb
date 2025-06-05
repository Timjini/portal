# app/models/assessment.rb
class Assessment < ApplicationRecord
  belongs_to :athlete, class_name: 'User'
  belongs_to :coach, class_name: 'User'

  enum :recommendation, {
    ready: 'ready',
    practice: 'practice',
    repeat: 'repeat'
  }, prefix: true

  validates :athlete_id, presence: true
  validates :coach_id, presence: true
  validate :coach_must_have_coach_role

  private

  def coach_must_have_coach_role
    errors.add(:coach, 'must be a coach') unless coach&.coach?
  end
end
