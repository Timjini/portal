# frozen_string_literal: true

require 'securerandom'

class User < ApplicationRecord # rubocop:disable Metrics/ClassLength
  # Devise Configuration
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  # accepts_nested_attributes_for :athlete_profile
  # Constants
  ROLE_TYPES = {
    athlete: 'athlete',
    parent_user: 'parent_user',
    child_user: 'child_user',
    coach: 'coach',
    admin: 'admin'
  }.freeze

  # Associations
  has_one_attached :avatar
  has_one :athlete_profile, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :qr_codes, dependent: :destroy
  has_many :user_checklists, dependent: :destroy
  has_many :user_levels, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :coach_calendars, dependent: :destroy

  has_many :user_logins, dependent: :destroy
  has_many :assessments, dependent: :destroy
  has_one :athlete_level
  has_many :attendance, dependent: :destroy

  # Scopes
  scope :coaches, -> { where(role: 'coach') }
  scope :by_role, ->(role) { role.present? ? where(role: role) : all }
  scope :parents, -> { where(role: 'parent_user') }
  scope :children, -> { where(role: 'child_user') }

  # Enums
  enum role: ROLE_TYPES # rubocop:disable Rails/EnumSyntax

  # Validations
  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 20 }

  validates :email,
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password,
            presence: true,
            on: :create

  validates :role,
            inclusion: { in: ROLE_TYPES.values }

  before_save :normalize_username
  # Callbacks
  before_create :assign_unique_color

  # Virtual Attributes
  attr_accessor :dob

  # scopes Methods
  scope :with_coach_calendars, lambda {
    includes(:coach_calendars)
  }

  scope :with_level, ->(level) {
    joins(:athlete_profile).where(athlete_profiles: { level: level })
  }

  ## Role Methods
  def parent_user?
    role == 'parent_user'
  end

  def admin?
    role == 'admin'
  end

  def child_users
    User.where(parent_id: id)
  end

  ## Profile Methods
  def avatar_thumbnail
    if avatar.attached?
      avatar
    else
      'user.png'
    end
  end

  def full_name
    return 'Unknown' unless first_name.present? && last_name.present?

    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def initials
    return 'N/A' unless first_name.present? && last_name.present?

    "#{first_name[0].upcase}#{last_name[0].upcase}"
  end

  def athlete_profile_data
    @athlete_profile_data ||= athlete_profile || NullAthleteProfile.new
  end

  delegate :height, :weight, :power_of_ten, :level,
           :child_password, :dob, to: :athlete_profile_data, prefix: true, allow_nil: true

  ## Level and Progress Methods
  def current_level
    return '---' if role.in?(%w[coach admin])

    level
  end

  def participation
    answers.find_by(question_id: 16)&.content || 'NO'
  end

  ## Authentication Methods
  def generate_jwt
    JWT.encode({ user_id: id, exp: 24.hours.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end

  def level
    l = AthleteProfile.find_by(user_id: id)
    return '---' if l.nil?

    l.level
  end
  

  def age # rubocop:disable Metrics/AbcSize
    profile = AthleteProfile.find_by(user_id: id)

    if profile&.dob
      dob = profile.dob
      current_date = Time.zone.today
      age = current_date.year - dob.year - (current_date.month > dob.month || (current_date.month == dob.month && current_date.day >= dob.day) ? 0 : 1) # rubocop:disable Layout/LineLength
      return age
    end

    # Return nil if there is no valid DOB
    nil
  end

  def height
    h = AthleteProfile.find_by(user_id: id)
    return '---' if h.nil?

    h.height
  end

  def weight
    w = AthleteProfile.find_by(user_id: id)
    return '---' if w.nil?

    w.weight
  end

  def power_of_ten
    p = AthleteProfile.find_by(user_id: id)
    return '---' if p.nil?

    p.power_of_ten
  end

  def child_password
    p = AthleteProfile.find_by(user_id: id)
    return '---' if p.nil?

    p.child_password
  end

  def athlete_profile_url
    if athlete_profile
      "/athlete_profiles/#{athlete_profile.id}"
    else
      ''
    end
  end

  def attended_today?
    attendance.exists?(['DATE(attended_at) = ? AND status = ?', Time.zone.today, 'present'])
  end

  
  def health_issue
    Answer.joins(:question)
    .where(user_id: self.id, content: 'Yes')
    .where.not(questions: { illness_tag: nil })
    .distinct
    .pluck('questions.illness_tag')
  end

  # Private Methods
  private

  def normalize_username
    self.username = username.downcase if username.present?
  end

  def assign_unique_color
    self.color = generate_unique_color
  end

  def generate_unique_color
    loop do
      color = "##{SecureRandom.hex(3)}"
      break color unless User.exists?(color: color)
    end
  end

  # Null Object Pattern for athlete profile
  class NullAthleteProfile
    def height = '---'
    def weight = '---'
    def power_of_ten = '---'
    def level = '---'
    def child_password = '---'
    def dob = nil
  end
end
