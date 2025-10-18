# frozen_string_literal: true

class CreateCompetitionEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :competition_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :competition, null: false, foreign_key: true
      t.string :status, default: 'subscribed'

      t.timestamps
    end

    add_index :competition_entries, %i[user_id competition_id], unique: true
  end
end
