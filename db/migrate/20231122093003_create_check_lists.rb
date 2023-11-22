class CreateCheckLists < ActiveRecord::Migration[7.1]
  def change
    create_table :check_lists do |t|
      t.string :title
      t.references :level, null: false, foreign_key: true

      t.timestamps
    end
  end
end
