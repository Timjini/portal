# frozen_string_literal: true

class AthleteProfile < ApplicationRecord
  MIN_AGE = 8
  MAX_AGE = 21
  # Associations
  belongs_to :user, inverse_of: :athlete_profile
  has_one_attached :image
  has_one :athlete_level, foreign_key: 'level' # rubocop:disable Rails/HasManyOrHasOneDependent,Rails/InverseOf

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :must_be_within_age_range
  delegate :first_name, :last_name, :email, to: :user, allow_nil: true

  # Enums
  enum :level, {
    development: 0,
    intermediate: 1,
    advanced: 2
  }, prefix: true

  # Callbacks
  before_validation :set_default_level, on: :create

  # Delegations
  delegate :email, to: :user, prefix: true, allow_nil: true

  # Class Methods
  class << self
    def age_categories
      {
        child: (0..12),
        junior: (13..18),
        senior: (19..60)
      }
    end
  end

  # Instance Methods
  def image_thumbnail
    return default_image_url unless image.attached?

    if Rails.env.production?
      image.variant(resize_to_limit: [150, 150]).processed
    else
      image
    end
  end

  def age
    return if dob.blank?

    now = Time.zone.today
    now.year - dob.year - (dob.to_date.change(year: now.year) > now ? 1 : 0)
  end

  def athlete_category
    return if age.blank?

    self.class.age_categories.find do |_category, range|
      range.cover?(age)
    end&.first.to_s.capitalize
  end

  def full_name
    [first_name, last_name].compact_blank.join(' ')
  end

  def full_name=(name)
    self.first_name, self.last_name = name.to_s.split(' ', 2)
  end

  def full_address
    [address, city].compact_blank.join(', ')
  end

  def check_lists
    user&.user_checklists || []
  end

  def athlete_levels
    user&.user_levels || []
  end

  def user_illnesses # rubocop:disable Metrics/MethodLength
    illness_mapping = {
      1 => 'Osgood Schlatter Disease',
      2 => 'Arthritis',
      3 => 'High blood pressure',
      4 => 'Low blood pressure',
      5 => 'Pain in their chest',
      6 => 'Heart condition',
      7 => 'Usage of drugs or medication'
    }

    positive_answers = Answer.where(
      user_id: user_id,
      question_id: illness_mapping.keys,
      content: 'Yes'
    ).pluck(:question_id)

    positive_answers.filter_map { |id| illness_mapping[id] }
  end

  private

  def set_default_level
    self.level ||= :development
  end

  def must_be_within_age_range
    return false if dob.blank?

    current_age = age
    return unless current_age < 8 || current_age > 21

    errors.add(:dob, "must result in an age between 8 and 21 (currently #{current_age})")
  end
end
