class AddDegreeToLevel < ActiveRecord::Migration[7.1]
  def change
    add_column :levels, :degree, :integer , default: 0
  end
end
