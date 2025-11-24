# frozen_string_literal: true

class ChangeLinkTypeInCompetitions < ActiveRecord::Migration[7.1]
  def up
    change_column :competitions, :link, :text
  end

  def down
    change_column :competitions, :link, :string
  end
end
