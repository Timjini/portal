class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    unless table_exists?(:reviews)
      create_table :reviews do |t|
        t.references :user, null: false, foreign_key: true
        t.references :coach, null: false, foreign_key: { to_table: :users }
        t.text :comment, null: false
        t.references :reviewable, polymorphic: true, null: false

        t.timestamps
      end
    end
  end
end
