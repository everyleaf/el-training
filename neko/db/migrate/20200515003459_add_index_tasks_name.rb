class AddIndexTasksName < ActiveRecord::Migration[6.0]
  def change
    add_index :tasks, :name
  end
end
