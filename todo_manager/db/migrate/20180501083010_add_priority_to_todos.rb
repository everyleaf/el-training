class AddPriorityToTodos < ActiveRecord::Migration[5.2]
  def change
    add_column :todos, :priority_id, :integer, null: false, default: 1, after: :content
  end
end
