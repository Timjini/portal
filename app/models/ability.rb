# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    return if user.blank? # Not logged in? No permissions

    if user.admin?
      can :manage, :all

    elsif user.coach?
      can :manage, Exercise
      can :manage, Assessment
      can :manage, Competition
      can :read, CoachCalendar
      can %i[read update edit update_user], User # Coaches can edit user profiles

    elsif user.parent_user?
      can :manage, User
      can :read, Competition

    else
      # Default for athlete, child_user
      can :read, Competition
      # Users can manage their own profile
      can %i[read update edit update_user], User, id: user.id
      can %i[read update edit update_user], AthleteProfile, user_id: user.id

    end
  end
end
