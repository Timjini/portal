class ChangeTitleToTextInCheckLists < ActiveRecord::Migration[7.1]
  def up
    change_column :check_lists, :title, :text
  end

  def down
    change_column :check_lists, :title, :string
  end
end
