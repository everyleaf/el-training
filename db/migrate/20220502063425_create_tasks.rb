class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string  :name,           null: false
      t.text    :description
      t.date    :start_date,     null: false
      t.integer :necessary_days, null: false
      t.integer :progress,       null: false, default: 0, comment: '0:未実行, 1:実行中, 2:完了'
      t.integer :priority,       null: false,             comment: '0:低, 1:中, 2:高'

      t.timestamps
    end
  end
end
