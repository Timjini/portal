class AddDegreeToUserLevel < ActiveRecord::Migration[7.1]
  def change
    add_column :user_levels, :degree, :string
  end
end
