module UserHelper
include AthleteProfilesHelper

    def create_user(email, first_name, last_name, phone, role, child_dob, athlete_dob, parent_email, parent_first_name, parent_last_name, parent_phone,child_name)
        if role == 'athlete'
            user = User.new
            user.email = email
            user.username = email.gsub(/[^a-zA-Z0-9]/, '_')
            user.first_name = first_name
            user.last_name = last_name
            user.phone = phone
            user.role = role
            user.save

            create_athlete_profile(user.id, child_dob)
        else
            parent = User.new
            parent.email = parent_email
            parent.username = parent_email.gsub(/[^a-zA-Z0-9]/, '_')
            parent.first_name = parent_first_name
            parent.last_name = parent_last_name
            parent.phone = parent_phone
            parent.role = "parent_user"
            parent.save

            child_first_name = child_name.split(' ')[0]
            child_last_name = child_name.split(' ')[1]

            child = User.new
            child.email = parent_email
            child.username = child_name.gsub(' ', '')
            child.first_name = child_first_name
            child.last_name = child_last_name
            child.role = "child_user"
            child.parent_id = parent.id
            child.save

            # Uncomment the following line if you want to call create_athlete_child_profile
            create_athlete_child_profile(child.id, child_dob, "school name", "password", nil, nil)
        end
    end

end