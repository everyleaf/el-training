class AddStatusToTodos < ActiveRecord::Migration[5.2]
  def change
    add_column :todos, :status_id, :integer, null: false, default: 0, after: :content
  end
end