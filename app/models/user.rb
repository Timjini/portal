class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
         
  
  has_one_attached :avatar
  has_one :athlete_profile
  
  validates_uniqueness_of :username
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validates :username, length: { minimum: 3, maximum: 20 }

  # searchkick text_middle: %i[username email first_name last_name]

   enum role: {
    'athlete' => 'athlete',
    'athlete_parent' => 'athlete_parent',
    'child_athlete' => 'child_athlete',
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
    "#{first_name} #{last_name}"
  end


end
