class AddReferencesToCategory < ActiveRecord::Migration[7.0]
  def change
    add_reference         :categories, :user,    foreign_key: true
    change_column_null    :categories, :user_id, false
  end
end
