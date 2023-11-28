module AthleteProfilesHelper

    def create_athlete_profile(user_id)
        profile = AthleteProfile.find_by(user_id: user_id)
        if profile.nil?
        @athlete_profile = AthleteProfile.create(user_id: user_id)
        else
        return profile
        end
    end

    def create_athlete_child_profile(user_id, dob, school,password, height, weight)
        profile = AthleteProfile.find_by(user_id: user_id)
        if profile.nil?
        @athlete_profile = AthleteProfile.create(user_id: user_id, dob: dob, school_name: school,child_password: password, height: height, weight: weight)
        else
        return profile
        end
    end
end
