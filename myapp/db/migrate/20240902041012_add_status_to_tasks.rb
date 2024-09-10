# frozen_string_literal: true

class AddStatusToTasks < ActiveRecord::Migration[7.0]
  def up
    add_column :tasks, :status, :integer, limit: 1, null: false, default: 0, unsigned: true, if_not_exists: true
    add_index :tasks, :status
  end

  def down
    remove_index :tasks, :status, if_exists: true
    remove_column :tasks, :status, if_exists: true
  end
end
