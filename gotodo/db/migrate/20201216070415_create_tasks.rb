class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :task_name, null: false
      t.text :detail
      t.text :location
      t.decimal :lat
      t.decimal :lng
      t.integer :status, limit: 1
      # t.references :priority, foreign_key: true <-後タスクで追加予定
      # t.references :user, foreign_key: true <-後タスクで追加予定
      t.datetime :end_date
      t.timestamps
    end
  end
end
