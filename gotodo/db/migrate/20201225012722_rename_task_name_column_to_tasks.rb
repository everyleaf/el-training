class RenameTaskNameColumnToTasks < ActiveRecord::Migration[6.1]
  def change
    rename_column :tasks, :task_name, :title
  end
end
