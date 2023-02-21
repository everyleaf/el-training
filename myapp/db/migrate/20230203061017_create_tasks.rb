class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.references :user, null: false
      t.integer :status, limit: 1, null: false, comment: '["waiting", "doing", "completed"]'
      t.string :title, null: false
      t.integer :priority, limit: 1, null: false, comment: '{0: "high", 1: "middle", 2: "low"}'
      t.text :description, null: false
      t.datetime :expires_at
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :tasks, %i[user_id status]
    add_index :tasks, %i[user_id title]
    add_index :tasks, %i[user_id priority]
    add_index :tasks, %i[user_id expires_at]
    add_index :tasks, %i[user_id status expires_at]
    add_index :tasks, %i[user_id status priority]
  end
end