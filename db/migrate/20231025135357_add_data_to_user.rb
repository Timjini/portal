# frozen_string_literal: true

class AddDataToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :phone, :string # rubocop:disable Rails/BulkChangeTable
    add_column :users, :address, :string
  end
end
