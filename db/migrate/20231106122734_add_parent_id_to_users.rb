class AddParentIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :parent_id, :string
  end
end
