class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|

      t.string :name
      t.integer :status, default: 0
      t.date :due_date

      t.timestamps
    end
  end
end
