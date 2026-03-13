# frozen_string_literal: true

class CreateNewsLetters < ActiveRecord::Migration[7.1]
  def change
    create_table :news_letters do |t|
      t.string :email
      t.string :name

      t.timestamps
    end
  end
end
