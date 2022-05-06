class ChangeTasksColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :tasks, :task_name,     :task_name
    rename_column :tasks, :abstract_text, :description
    rename_column :tasks, :status,        :progress

    change_column_null :tasks, :name,          false
    change_column_null :tasks, :description,   false
    change_column_null :tasks, :start_date,    false
    change_column_null :tasks, :deadline_date, true
    change_column_null :tasks, :progress,      falsegit add .
    
  end
end
