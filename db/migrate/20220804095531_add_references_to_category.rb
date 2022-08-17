class AddReferencesToCategory < ActiveRecord::Migration[7.0]
  def change
    add_reference         :categories, :user, foreign_key: true, null: false
    add_index             :categories, %i(name user_id), unique: true
  end
end
