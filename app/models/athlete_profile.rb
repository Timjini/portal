class AthleteProfile < ApplicationRecord
  belongs_to :user , optional: true
  # has_one_attached :image

  # validates :last_name, uniqueness: { case_sensitive: false }
  # validates :first_name, uniqueness: { case_sensitive: false }
  # validates_presence_of :first_name, :last_name


    enum level: {
    development:0,
    intermediate:1,
    advance:2
  }

   def image_thumbnail
    if image.attached?
      # avatar.variant(resize: "150x150!").processed
      image
    else
      "https://imgur.com/a/SqiBbyF"
    end
  end

    def age
    now = Time.now.utc.to_date
    if dob.nil?
      return ""
    else
    now.year - dob.year - (dob.to_date.change(:year => now.year) > now ? 1 : 0)
    end
  end

   def athlete_category
    case age 
    when 0..12
      "Child"
    when 13..18
      "Junior"
    when 19..60
      "Senior"
    end
  end

  def athlete_full_name
    "#{first_name} #{last_name}"
  end

  def full_name=(name)
    parts = name.split(" ", 2)
    self.first_name = parts[0]
    self.last_name = parts[1]
  end

  def full_address
    "#{address} #{city}"
  end

  def check_lists
    user = User.find(self.user_id)
    user.user_checklists
  end

  def athlete_level
    user = User.find(self.user_id)
    user.user_levels
  end

  def default_level
    self.level = 0
  end

  def user_illness
    illnesses_list = {
      "Osgood Schlatter Disease" => 1,
      "Arthritis" => 2,
      "high blood pressure" => 3,
      "low blood pressure" => 4,
      "pain in their chest" => 5,
      "heart condition" => 6,
      "usage of drugs or medication" => 7
    }

    questions = Question.where(id: 1..10)
    answers = Answer.where(user_id: self.user_id, question_id: questions.pluck(:id))

    illness_tags = []

    answers.each do |a|
      if a.content == "Yes" 
        illnesses_list.each { |key, value| illness_tags << key if a.question.id == value }
      end
    end

    illness_tags.presence || nil
  end


end