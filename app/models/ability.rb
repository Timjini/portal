# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    nil if user.blank? # rubocop:disable Lint/Void
    user ||= User.new # guest user

    if user.admin?
      can :manage, :all
    elsif user.coach?
      can :manage, Exercise
      can :read, CoachCalendar
      # add more coach-specific rules
    else
      # Default for athlete, child_user, or parent

      # Allow user to read/update their own user record
      can %i[read update], User, id: user.id

      if user.role == 'parent_user'
        can [:read, :update], User, id: user.id
        
        can [:read, :update], User, parent_id: user.id
      
      elsif user.role == 'child_user'
        can [:read, :update], User, id: user.id
        can :read, User, id: user.parent_id if user.parent_id.present?
      end

      # Add any other athlete-specific permissions here
    end

    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
