class ChangeTasksColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :tasks, :task_name,     :name
    rename_column :tasks, :abstract_text, :description
    rename_column :tasks, :status,        :progress

    change_column_null :tasks, :name,          false
    change_column_null :tasks, :description,   false
    change_column_null :tasks, :start_date,    false, Time.zone.today
    change_column_null :tasks, :deadline_date, true
    change_column_null :tasks, :progress,      false, 0

    change_column_comment :tasks, :progress, from: nil, to: '0:未実行, 1:実行中, 2:完了'
  end
end
