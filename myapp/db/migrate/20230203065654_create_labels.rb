class CreateLabels < ActiveRecord::Migration[7.0]
  def change
    create_table :labels do |t|
      t.string :name, :null => false
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :labels, :name
  end
end
