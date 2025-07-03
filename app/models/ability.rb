class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present? # Not logged in? No permissions

    if user.admin?
      can :manage, :all

    elsif user.coach?
      can :manage, Exercise
      can :read, CoachCalendar
      can %i[read update edit update_user], User # Coaches can edit user profiles (optional, based on your logic)

    else
      # Default for athlete, child_user, parent_user, etc.

      # Users can manage their own profile
      can %i[read update edit update_user], User, id: user.id
      can %i[read update edit update_user], AthleteProfile, user_id: user.id

    end
  end
end
