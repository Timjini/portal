# frozen_string_literal: true

class AddStepToLevel < ActiveRecord::Migration[7.1]
  def change
    add_column :levels, :step, :integer
  end
end
