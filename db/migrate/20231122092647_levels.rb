class Levels < ActiveRecord::Migration[7.1]
  def change
      create_table :levels do |t|
        t.string :title

        t.timestamps
      end
  end
end
