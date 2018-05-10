class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :password_digest, null: false
      t.integer :user_type, null: false, default: 1

      t.timestamps
    end
  end
end
