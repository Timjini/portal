# frozen_string_literal: true

class AddIllnessTagToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :illness_tag, :string
  end
end
