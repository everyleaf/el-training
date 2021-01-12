class CreateLabels < ActiveRecord::Migration[6.1]
  def up
    remove_column :tasks, :label_id

    create_table :labels do |t|
      t.string :name, null: false, limit: 50
      t.timestamps
    end

    create_table :task_label_relations do |t|
      t.bigint :task_id, null: false
      t.bigint :label_id, null: false
      t.timestamps
    end

    add_index :labels, :name, unique: true
    add_foreign_key :task_label_relations, :tasks
    add_foreign_key :task_label_relations, :labels
  end

  def down
    add_column :tasks, :label_id, :integer
    remove_index :labels, :name
    remove_foreign_key :task_label_relations, :tasks
    remove_foreign_key :task_label_relations, :labels
    drop_table :task_label_relations
    drop_table :labels
  end
end
