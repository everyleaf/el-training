class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :users, :name
    add_index :users, :email, unique: true
  end
end
