class AddStatusToTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :status, null: false, foreign_key: true, default: 1
  end
end
