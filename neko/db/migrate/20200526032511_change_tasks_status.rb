class ChangeTasksStatus < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :status, :integer, null: false, default: 0
    add_index :tasks, :status
  end
end
