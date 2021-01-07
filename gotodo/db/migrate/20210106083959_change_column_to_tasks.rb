class ChangeColumnToTasks < ActiveRecord::Migration[6.1]
  def up
    change_column :tasks, :title, :string, limit: 50
    change_column :tasks, :detail, :string, limit: 200
  end

  def down
    change_column :tasks, :title, :string
    change_column :tasks, :detail, :text
  end
end
