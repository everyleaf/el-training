class CreateTaskLabels < ActiveRecord::Migration[7.0]
  def change
    create_table :task_labels do |t|
      t.references :task, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true

      t.timestamps
    end
  end
end
