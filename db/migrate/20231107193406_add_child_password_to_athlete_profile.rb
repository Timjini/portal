class AddChildPasswordToAthleteProfile < ActiveRecord::Migration[7.1]
  def change
    add_column :athlete_profiles, :child_password, :string
  end
end
