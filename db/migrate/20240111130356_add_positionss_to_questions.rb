# frozen_string_literal: true

class AddPositionssToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :position, :integer
  end
end
