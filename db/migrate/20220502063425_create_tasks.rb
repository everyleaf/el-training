class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string  :name,          null: false
      t.text    :description,   null: false
      t.date    :start_date,    null: false, default: Time.zone.today
      t.date    :deadline_date
      t.integer :progress,      null: false, default: 0, comment: '0:未実行, 1:実行中, 2:完了'

      t.timestamps
    end
  end
end
