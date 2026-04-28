# frozen_string_literal: true

class CreateFeeds < ActiveRecord::Migration[7.1]
  def change
    create_table :feeds do |t|
      t.references :user, null: false, foreign_key: true
      t.string :feed_type
      t.string :title
      t.text :description
      t.json :metadata

      t.timestamps
    end
  end
end
