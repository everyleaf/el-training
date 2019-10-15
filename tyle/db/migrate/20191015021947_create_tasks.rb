class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.integer :priority
      t.integer :status
      t.datetime :due
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
