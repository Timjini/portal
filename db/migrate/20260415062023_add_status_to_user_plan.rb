class AddStatusToUserPlan < ActiveRecord::Migration[7.1]
  def change
    add_column :user_plans, :status, :string, default: 'pending' # rubocop:disable Rails/BulkChangeTable
  end
end
