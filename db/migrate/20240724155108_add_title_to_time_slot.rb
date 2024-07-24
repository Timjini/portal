class AddTitleToTimeSlot < ActiveRecord::Migration[7.1]
  def change
    add_column :time_slots,:title , :string
  end
end
