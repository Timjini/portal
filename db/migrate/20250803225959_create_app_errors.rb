class CreateAppErrors < ActiveRecord::Migration[7.1]
  def change
    create_table :app_errors do |t|
      t.string :error_type
      t.text :message
      t.text :backtrace
      t.datetime :occurred_at
      t.json :context

      t.timestamps
    end
  end
end
