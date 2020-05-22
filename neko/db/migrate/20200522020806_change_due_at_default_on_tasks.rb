class ChangeDueAtDefaultOnTasks < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tasks, :due_at, from: -> { "CURRENT_TIMESTAMP" }, to: nil
  end
end
