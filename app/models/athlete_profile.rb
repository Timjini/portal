# frozen_string_literal: true

class AthleteProfile < ApplicationRecord
  # Associations
  belongs_to :user, optional: true
  has_one_attached :image
  has_one :athlete_level, foreign_key: 'level'

  # Validations
  # validates :first_name, :last_name, presence: true
  # validates :first_name, uniqueness: { scope: :last_name, case_sensitive: false }

  # Enums
  enum :level, {
    development: 0,
    intermediate: 1,
    advanced: 2 # Fixed typo from 'advance' to 'advanced'
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
end
