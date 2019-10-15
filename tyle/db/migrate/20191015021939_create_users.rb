class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :login_id
      t.string :password_digest
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
