class AddActivationToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :activation_digest
      t.boolean :activated, default: false
      t.datetime :activated_at
    end
  end
end
