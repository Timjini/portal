# frozen_string_literal: true

class TasterSessionBooking < ApplicationRecord
  def full_name_by_role
    return "#{first_name} #{last_name}" if role == 'athlete'

    athlete_full_name
  end
end
