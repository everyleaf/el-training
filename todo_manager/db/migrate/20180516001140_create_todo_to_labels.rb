class CreateTodoToLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :todo_to_labels do |t|
      t.belongs_to :todo, foreign_key: true, index: true
      t.belongs_to :label, foreign_key: true, index: true

      t.timestamps
    end
  end
end
