class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :title
      t.string :text
      t.string :description
      t.integer :priority
      t.integer :status
      t.string :due
      t.string :date
      t.integer :label_id

      t.timestamps
    end
  end
end
