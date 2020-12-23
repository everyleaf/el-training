# frozen_string_literal: true

class AddColumnTasks < ActiveRecord::Migration[6.1]
  def up
    change_column :tasks, :name, :string, null: false
    change_column :tasks, :created_at, :timestamp, default: -> { 'CURRENT_TIMESTAMP' }
    change_column :tasks, :updated_at, :timestamp, default: -> { 'CURRENT_TIMESTAMP' }
    add_column :tasks, :priority, :string, null: false, default: 'low', limit: 6
    add_column :tasks, :status, :string, null: false, default: 'todo', limit: 5
    add_column :tasks, :user_id, :integer
    add_column :tasks, :label_id, :integer
    add_column :tasks, :target_date, :date
    execute "ALTER TABLE `tasks` ADD CONSTRAINT `check_tasks_priority` CHECK (`priority` IN ('high', 'medium', 'low'))"
    execute "ALTER TABLE `tasks` ADD CONSTRAINT `check_tasks_status` CHECK (`status` IN ('todo', 'doing', 'done'))"
  end

  def down
    execute 'ALTER TABLE `tasks` DROP CONSTRAINT `check_tasks_priority`'
    execute 'ALTER TABLE `tasks` DROP CONSTRAINT `check_tasks_status`'
    remove_column :tasks, :priority, :string
    remove_column :tasks, :status, :string
    remove_column :tasks, :user_id, :integer
    remove_column :tasks, :label_id, :integer
    remove_column :tasks, :target_date, :date
    change_column :tasks, :name, :string, null: true
    change_column :tasks, :created_at, :timestamp
    change_column :tasks, :updated_at, :timestamp
  end
end
