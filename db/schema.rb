# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_20_000551) do

  create_table "foods", force: :cascade do |t|
    t.string "food_name"
    t.string "search_name"
    t.string "quantifier"
    t.integer "calorie"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "sugar", default: 0.0
  end

  create_table "meal_records", force: :cascade do |t|
    t.string "meal_content"
    t.integer "total_calorie"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "total_sugar", default: 0
    t.index ["user_id"], name: "index_meal_records_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "todo"
    t.string "not_todo"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.integer "point", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "meal_records", "users"
  add_foreign_key "tasks", "users"
end
