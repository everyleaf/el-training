class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      # TODO: ユーザモデルが追加されたら、nameのユニーク性のスコープをユーザに変更する
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
