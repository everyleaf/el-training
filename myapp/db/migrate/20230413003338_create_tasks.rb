class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string  :title, null: false
      t.string  :outline, null: false
      t.timestamps
    end
  end
end
