class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.integer :priority, limit: 1
      t.integer :status, limit:1, default: 0
      t.date :due_date

      t.timestamps
    end
  end
end
