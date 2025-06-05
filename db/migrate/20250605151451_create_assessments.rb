class CreateAssessments < ActiveRecord::Migration[7.1]
  def change
    create_table :assessments do |t|
      t.references :athlete, null: false, foreign_key: { to_table: :users }
      t.references :coach, null: false, foreign_key: { to_table: :users }
      t.jsonb :kpi_data
      t.string :recommendation
      t.text :notes

      t.timestamps
    end
  end
end
