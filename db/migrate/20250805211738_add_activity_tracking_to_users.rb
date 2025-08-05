# frozen_string_literal: true

class AddActivityTrackingToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :active, :boolean, default: true # rubocop:disable Rails/BulkChangeTable,Rails/ThreeStateBooleanColumn
    add_column :users, :last_login_at, :datetime
    add_column :users, :login_count, :integer, default: 0
    add_column :users, :error_count, :integer, default: 0
  end
end
