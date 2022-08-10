class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title, limit: 128, null: false, default: ''
      t.text :content, limit: 1024
      t.integer :user_id
      t.string :status, limit: 1, null: false, default: '1'
      t.string :label, limit: 64
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
