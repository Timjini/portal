class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

      
         
  
  has_one_attached :avatar
  has_one :athlete_profile
  has_many :qr_codes
  
  validates_uniqueness_of :username
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validates :username, length: { minimum: 3, maximum: 20 }

  # searchkick text_middle: %i[username email first_name last_name]

   enum role: {
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
      "/assets/user.png"
    end
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  # def name
  #   "#{first_name} #{last_name}"
  # end

  def age
    profile = AthleteProfile.find_by(user_id: self.id)
    
    if profile && profile.dob
      dob = profile.dob
      current_date = Date.today
      age = current_date.year - dob.year - ((current_date.month > dob.month || (current_date.month == dob.month && current_date.day >= dob.day)) ? 0 : 1)
      return age
    end

    # Return nil if there is no valid DOB
    nil
  end

  def height
    h = AthleteProfile.find_by(user_id: self.id)
    if h.nil?
       return "---"
    else
      h.height
    end
  end

  def weight
    w = AthleteProfile.find_by(user_id: self.id)
    if w.nil?
       return "---"
    else
      w.weight
    end
  end

  def power_of_ten
    p = AthleteProfile.find_by(user_id: self.id)
    if p.nil?
      return "---"
    else
      p.power_of_ten
    end
  end

  
  def level
    l = AthleteProfile.find_by(user_id: self.id)
    if l.nil?
      return "---"
    else
      l.level
    end
  end



end
