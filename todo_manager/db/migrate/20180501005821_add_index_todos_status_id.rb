class AddIndexTodosStatusId < ActiveRecord::Migration[5.2]
  def change
    add_index :todos, [:status_id, :title]
  end
end
