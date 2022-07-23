class AddTaskToTaskCategory < ActiveRecord::Migration[7.0]
  def change
    add_reference :task_categories, :task, null: false, foreign_key: true
  end
end
