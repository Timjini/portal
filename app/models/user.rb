class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :avatar
  has_one :athlete_profile

  # searchkick text_middle: %i[username email first_name last_name]

  enum role: { athlete: 0, parent_role: 1, child_athlete: 2, coach: 3, admin: 4 }

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
