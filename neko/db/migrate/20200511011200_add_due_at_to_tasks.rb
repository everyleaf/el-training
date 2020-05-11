class AddDueAtToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :due_at, :datetime, default: -> { 'NOW()' }, null: false
    add_column :tasks, :have_a_due, :boolean, default: false, null: false
  end
end
