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

ActiveRecord::Schema[7.0].define(version: 2022_05_02_063425) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.date "start_date", null: false
    t.integer "necessary_days", null: false
    t.integer "progress", default: 0, null: false, comment: "0:未実行, 1:実行中, 2:完了"
    t.integer "priority", null: false, comment: "0:低, 1:中, 2:高"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
