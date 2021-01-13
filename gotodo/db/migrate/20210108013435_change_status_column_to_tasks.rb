class ChangeStatusColumnToTasks < ActiveRecord::Migration[6.1]
  def up
    change_column_null :tasks, :status, false, 0
    change_column :tasks, :status, :integer, default: 0
  end

  def down
    change_column_null :tasks, :status, true
    change_column :tasks, :status, :integer, default: nil
  end
end
