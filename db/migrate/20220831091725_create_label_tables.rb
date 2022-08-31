class CreateLabelTables < ActiveRecord::Migration[7.0]
  def change
    create_table :label_tables do |t|
      t.references :task, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true

      t.timestamps
    end
  end
end
