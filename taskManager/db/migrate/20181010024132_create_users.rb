class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :mail, null: false
      t.string :user_name, null: false
      t.string :encrypted_password, null: false

      t.timestamps
    end
  end
end
