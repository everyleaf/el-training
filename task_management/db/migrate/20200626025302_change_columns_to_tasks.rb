class ChangeColumnsToTasks < ActiveRecord::Migration[6.0]
  def up
    change_column :tasks, :title, :string, limit: 20, null: false
    change_column :tasks, :description, :text
    change_column :tasks, :priority, :integer, limit: 1, null: false
    change_column :tasks, :status, :integer, limit: 1, null: false
    change_column :tasks, :due, :date
  end

  def down
    change_column :tasks, :title, :string
    change_column :tasks, :description, :string
    change_column :tasks, :priority, :integer
    change_column :tasks, :status, :integer
    change_column :tasks, :due, :string
  end
end
