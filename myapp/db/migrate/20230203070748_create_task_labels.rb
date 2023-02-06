class CreateTaskLabels < ActiveRecord::Migration[7.0]
  def change
    create_table :task_labels do |t|
      t.integer :task_id, foreign_key: true, null: false
      t.integer :label_id, foreign_key: true, null: false

      t.timestamps
    end
    add_index :task_labels, :task_id
    add_index :task_labels, :label_id
  end
end
