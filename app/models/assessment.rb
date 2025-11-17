# frozen_string_literal: true

# app/models/assessment.rb
class Assessment < ApplicationRecord
  belongs_to :athlete, class_name: 'User'
  belongs_to :coach, class_name: 'User'
  belongs_to :level, optional: true
  has_many :assessment_checklists, dependent: :destroy
  has_many :checklists, through: :assessment_checklists

  enum :recommendation, {
    ready: 'ready',
    practice: 'practice',
    repeat: 'repeat'
  }, prefix: true

  # --- Validations ---
  validates :recommendation, inclusion: { in: recommendations.keys }, allow_nil: true
  validates :notes, length: { maximum: 1000 }, allow_blank: true
  validates :kpi_data, presence: true
  validates :completed, inclusion: { in: [true, false] }

  # Ensure completed_at is present if completed = true
  validate :completed_at_required_if_completed

  # Ensure coach has correct role
  validate :coach_must_have_coach_role

  private

  def coach_must_have_coach_role
    return if coach&.coach? || coach&.admin?

    errors.add(:coach, 'must have the coach or admin role')
  end

  def completed_at_required_if_completed
    return unless completed? && completed_at.blank?

    errors.add(:completed_at, 'must be set when assessment is marked as completed')
  end
end
