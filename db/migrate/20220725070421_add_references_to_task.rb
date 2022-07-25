class AddReferencesToTask < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :category, foreign_key: true
  end
end
