class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :task_id
      t.date :Date
      t.string :schedule
      t.datetime :end_time
      t.string :status

      t.timestamps
    end
  end
end
