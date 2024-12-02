# frozen_string_literal: true

class CreateQuestionnaires < ActiveRecord::Migration[7.1]
  def change
    create_table :questionnaires do |t|
      t.string :title
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
