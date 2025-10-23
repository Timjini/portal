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
      can :manage, AthleteProfile
      can :read, CoachCalendar
      can %i[read update edit update_user], User # Coaches can edit user profiles
      can :manage, UserChecklist
      can :manage, Review

    elsif user.parent_user?
      can :manage, User, id: [user.id] + user.children.pluck(:id)
      can :index, Competition
      can %i[read update edit update_user], AthleteProfile, user_id: user.children.pluck(:id)

    else
      # Default for athlete, child_user
      can :index, Competition
      # Users can manage their own profile
      can %i[read update edit update_user], User, id: user.id
      can %i[read update edit update_user], AthleteProfile, user_id: user.id
      can :read, UserChecklist, user_id: user.id
      can :read, Review, user_id: user.id

    end
  end
end
