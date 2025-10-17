# frozen_string_literal: true

class CreateCompetitions < ActiveRecord::Migration[7.1]
  def change
    create_table :competitions do |t|
      t.string :title
      t.date :date
      t.string :link

      t.timestamps
    end
  end
end
