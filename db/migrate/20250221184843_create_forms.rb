class CreateForms < ActiveRecord::Migration[7.1]
  def change
    create_table :forms do |t|
      t.string :email, null:false
      t.string :title
      t.string :name, null:false
      t.string :phone, null:false
      t.string :subject
      t.string :status
      t.text :message
      t.timestamps
    end
  end
end
