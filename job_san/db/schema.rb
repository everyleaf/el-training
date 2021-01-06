# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_06_054519) do

  create_table "tasks", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "priority", limit: 6, default: "low", null: false
    t.string "status", limit: 5, default: "todo", null: false
    t.string "user_id", limit: 36
    t.integer "label_id"
    t.date "target_date"
    t.index ["name"], name: "index_tasks_on_name"
    t.index ["status"], name: "index_tasks_on_status"
    t.index ["user_id"], name: "fk_rails_4d2a9e4d7e"
    t.check_constraint "`priority` in ('high','medium','low')", name: "check_tasks_priority"
    t.check_constraint "`status` in ('todo','doing','done')", name: "check_tasks_status"
  end

  create_table "users", id: { type: :string, limit: 36, default: -> { "(uuid())" } }, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.timestamp "deleted_at", comment: "for soft delete"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "tasks", "users"
end
