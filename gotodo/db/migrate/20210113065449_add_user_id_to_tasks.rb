class AddUserIdToTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :tasks, :user, foreign_key: true, index: true
    change_column_null :tasks, :user_id, false, 1
  end
end
