class ChangeKpiDataToMediumtextInAssessments < ActiveRecord::Migration[7.1]
  def up
    change_column :assessments, :kpi_data, :mediumtext
  end

  def down
    change_column :assessments, :kpi_data, :json
  end
end
