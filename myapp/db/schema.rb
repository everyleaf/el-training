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

ActiveRecord::Schema[7.0].define(version: 2023_02_03_061017) do
  create_table "tasks", charset: "utf8mb4", force: :cascade do |t|
    t.integer "owner_id", null: false
    t.string "status", null: false, comment: "[\"waiting\", \"doing\", \"completed\"]"
    t.string "title", null: false
    t.integer "priority", limit: 1, null: false, comment: "{1: \"high\", 2: \"middle\", 3: \"low\"}"
    t.text "description", null: false
    t.datetime "expires_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "expires_at"], name: "index_tasks_on_owner_id_and_expires_at"
    t.index ["owner_id", "priority"], name: "index_tasks_on_owner_id_and_priority"
    t.index ["owner_id", "status", "expires_at"], name: "index_tasks_on_owner_id_and_status_and_expires_at"
    t.index ["owner_id", "status", "priority"], name: "index_tasks_on_owner_id_and_status_and_priority"
    t.index ["owner_id", "status"], name: "index_tasks_on_owner_id_and_status"
    t.index ["owner_id", "title"], name: "index_tasks_on_owner_id_and_title"
    t.index ["owner_id"], name: "index_tasks_on_owner_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
  end

end
