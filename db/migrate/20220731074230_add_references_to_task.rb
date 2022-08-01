class AddReferencesToTask < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :category, foreign_key: true
    change_column :tasks, :category_id, :integer, default: Category.find_by(name: "未分類"), null: false
  end
end
