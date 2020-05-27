class UpdateTasks < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      change_table :tasks do |t|
        dir.up   { t.change :name, :string }
        dir.down { t.change :name, :string, null: false }
      end
    end
  end
end
