class TasterSessionBooking < ApplicationRecord

    def full_name_by_role
        if self.role == "athlete"
            return "#{self.first_name} #{self.last_name}"
        else
            return self.athlete_full_name
        end
    end
end