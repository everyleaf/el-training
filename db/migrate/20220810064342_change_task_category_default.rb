class ChangeTaskCategoryDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :tasks, :category_id,
                          from: Category.find_by(name: Category::DEFAULT_CREATED_CATEGORY),
                          to: nil
  end
end
