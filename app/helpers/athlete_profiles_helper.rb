# frozen_string_literal: true

module AthleteProfilesHelper
  def create_athlete_profile(user_id, dob)
    profile = AthleteProfile.find_by(user_id: user_id)
    return profile unless profile.nil?

    @athlete_profile = AthleteProfile.create(user_id: user_id, level: 0, dob: dob) # rubocop:disable Rails/HelperInstanceVariable
  end

  def create_athlete_child_profile(user_id, dob, school, password, height, weight) # rubocop:disable Metrics/ParameterLists
    profile = AthleteProfile.find_by(user_id: user_id)
    return profile unless profile.nil?

    @athlete_profile = AthleteProfile.create(user_id: user_id, dob: dob, school_name: school, # rubocop:disable Rails/HelperInstanceVariable
                                             child_password: password, height: height, weight: weight, level: 0)
  end
end
