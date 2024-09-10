# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title, limit: 50
      t.string :description, limit: 500

      t.timestamps
    end
  end
end
