class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, :limit => 128, :null => false, :default => ''
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
