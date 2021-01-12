class CreateUsers < ActiveRecord::Migration[6.1]
  def up
    create_table :users, id: false do |t|
      t.string :id, limit: 36, null: false, primary_key: true, default: ->{"(uuid())"}
      t.string :name, null: false, limit: 100
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :remember_digest
      t.timestamp :deleted_at, comment: 'for soft delete'
      t.timestamps
    end

    change_column :tasks, :user_id, :string, limit: 36

    if Task.select(:id).where(user_id: nil).limit(1)
      password = 'password'
      u = User.create(name: 'sample', email: 'xxx@gmail.com', password: password, password_confirmation: password)
      Task.where(user_id: nil).update_all(user_id: u.id)
    end
    add_index :users, :email, unique: true
    add_foreign_key :tasks, :users
  end

  def down
    remove_foreign_key :tasks, :users
    remove_index :users, :email
    Task.all.update_all(user_id: nil)
    change_column :tasks, :user_id, :integer
    drop_table :users
  end
end
