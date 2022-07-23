class AddReferencesToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :task_category, foreign_key: true
  end
end
