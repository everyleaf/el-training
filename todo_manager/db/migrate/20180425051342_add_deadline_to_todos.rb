class AddDeadlineToTodos < ActiveRecord::Migration[5.2]
  def change
    add_column :todos, :deadline, :datetime, after: :content
  end
end
