# frozen_string_literal: true

class ChangeTitleToTasks < ActiveRecord::Migration[7.0]
  def up
    add_index :tasks, :title
    change_column_null :tasks, :title, false
  end

  def down
    remove_index :tasks, :title
    change_column_null :tasks, :title, true
  end
end
