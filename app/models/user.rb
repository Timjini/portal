# frozen_string_literal: true

require 'securerandom'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  before_create :assign_unique_color

  attr_accessor :dob

  has_many :comments
  has_one_attached :avatar
  has_one :athlete_profile, dependent: :destroy
  has_many :qr_codes
  has_many :user_checklists, dependent: :destroy
  has_many :user_levels, dependent: :destroy
  has_many :answers, dependent: :destroy

  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :username, uniqueness: true
  # # validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validates :password, presence: true
  # validates :username, length: { minimum: 3, maximum: 20 }

  # searchkick text_middle: %i[username email first_name last_name]

  def generate_jwt
    JsonWebToken.encode({ user_id: id })
  end

  enum :role, {
    'athlete' => 'athlete',
    'parent_user' => 'parent_user',
    'child_user' => 'child_user',
    'coach' => 'coach',
    'admin' => 'admin'
  }

  def avatar_thumbnail
    if avatar.attached?
      # avatar.variant(resize: "150x150!").processed
      avatar
    else
      'user.png'
    end
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  # def name
  #   "#{first_name} #{last_name}"
  # end

  def age
    profile = AthleteProfile.find_by(user_id: id)

    if profile&.dob
      dob = profile.dob
      current_date = Time.zone.today
      age = current_date.year - dob.year - (current_date.month > dob.month || (current_date.month == dob.month && current_date.day >= dob.day) ? 0 : 1)
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

  def level
    l = AthleteProfile.find_by(user_id: id)
    return '---' if l.nil?

    l.level
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

  def current_level
    user_level = UserLevel.where(user_id: id, status: 'completed').count

    case user_level
    when 0..5
      'Beginner'
    when 6..10
      'Intermediate'
    when 11..15
      'Advanced'
    when 16..20
      'Elite'
    when 21..25
      'Pro'
    end
  end

  def participation
    # participating in event question number 16
    answer = Answer.find_by(user_id: id, question_id: 16)

    if answer.nil?
      'NO'
    else
      answer.content
    end
  end

  def assign_unique_color
    existing_colors = User.pluck(:color)
    self.color = generate_unique_color(existing_colors)
  end

  def generate_unique_color(existing_colors)
    loop do
      color = SecureRandom.hex(3)
      color = "##{color}"
      break color unless existing_colors.include?(color)
    end
  end
end
