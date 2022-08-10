class ChangeTaskCategoryDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :tasks, :category_id,
                          from: Category.find_by(name: '未分類'),
                          to: nil
  end
end
