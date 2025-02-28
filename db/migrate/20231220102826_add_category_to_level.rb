# frozen_string_literal: true

class AddCategoryToLevel < ActiveRecord::Migration[7.1]
  def change
    add_column :levels, :category, :integer, default: 0
  end
end
