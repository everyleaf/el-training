class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :task_name, null: false
      t.text :description, null: false
      t.integer :user_id, null: false
      t.date :deadline
      t.integer :priority, null: false
      t.integer :status, null: false

      t.timestamps
    end
  end
end
