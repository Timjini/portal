module OnboardingHelper
  def check_onboarding(user)
    if %i[parent_user child_user athlete].include?(user.role)
      return Answer.find_by(user_id: user.id) ? true : false
    end
  end
end