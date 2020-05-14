class CreateStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :statuses do |t|
      t.string  :name,  null: false, unique: true
      t.integer :phase, null: false, unique: true

      t.timestamps
    end
  end
end
