# frozen_string_literal: true

class AddDueDateAtToTasks < ActiveRecord::Migration[7.0]
  def up
    add_column :tasks, :due_date_at, :datetime, if_not_exists: true
    add_index :tasks, :due_date_at
  end

  def down
    remove_column :tasks, :due_date_at, :datetime, if_exists: true
  end
end
