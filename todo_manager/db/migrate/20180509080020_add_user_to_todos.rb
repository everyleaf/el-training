class AddUserToTodos < ActiveRecord::Migration[5.2]
  def change
    add_reference :todos, :user, index: true, foreign_key: true, after: :content
  end
end
