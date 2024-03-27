class AddExplinationToAnswers < ActiveRecord::Migration[7.1]
  def change
    add_column :answers, :explination, :string
  end
end
