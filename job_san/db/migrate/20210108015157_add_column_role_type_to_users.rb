class AddColumnRoleTypeToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :role_type, :string, null: false, default: 'member', limit: 6
    if User.exists?
      User.update_all(role_type: 'member')
    end
    execute "ALTER TABLE `users` ADD CONSTRAINT `check_users_role_type` CHECK (`role_type` IN ('member', 'admin'))"
  end

  def down
    execute 'ALTER TABLE `users` DROP CONSTRAINT `check_users_role_type`'
    remove_column :users, :role_type, :string
  end
end
