class ChangeTasksColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :tasks, :task_name,     :task_name
    rename_column :tasks, :abstract_text, :description
    rename_column :tasks, :status,        :progress
  end
end
