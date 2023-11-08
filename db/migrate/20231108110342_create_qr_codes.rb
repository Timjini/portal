class CreateQrCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :qr_codes do |t|
      t.boolean :scanned, default: false
      t.string :data
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
    
    add_index :qr_codes, :scanned, unique: true
  end
end
