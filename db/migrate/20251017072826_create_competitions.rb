# frozen_string_literal: true

class CreateCompetitions < ActiveRecord::Migration[7.1]
  def change
    create_table :competitions do |t|
      t.string :title
      t.string :description
      t.date :date
      t.string :link
      t.string :status, default: 'active'

      t.timestamps
    end
  end
end
