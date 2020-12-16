class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.text :detail
      t.text :location
      t.decimal :lat
      t.decimal :lng
      t.integer :priority_no
      t.integer :status_no
      t.integer :user_id
      t.datetime :end_date
      t.timestamps
    end
  end
end
