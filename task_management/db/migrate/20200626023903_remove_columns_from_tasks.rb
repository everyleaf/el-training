class RemoveColumnsFromTasks < ActiveRecord::Migration[6.0]
  def change
    remove_column :tasks, :text, :satring
    remove_column :tasks, :date, :string
  end
end
