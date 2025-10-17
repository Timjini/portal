# frozen_string_literal: true

class AddIndexesToChecklistItems < ActiveRecord::Migration[7.1]
  def change
    add_index :user_checklists, %i[user_id check_list_id completed]
    add_index :user_checklists, %i[check_list_id user_id completed]
  end
end
