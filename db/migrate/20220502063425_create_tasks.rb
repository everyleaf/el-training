class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.text :abstract_text
      t.date :start_date
      t.date :deadline_date
      t.integer :status

      t.timestamps
    end
  end
end
