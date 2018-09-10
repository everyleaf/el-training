class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :task_title
      t.string :task_content
      t.datetime :create_time
      t.datetime :modify_time
      t.string :status

      t.timestamps
    end
  end
end
