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

ActiveRecord::Schema[7.1].define(version: 2024_07_17_231853) do
  create_table "daily_exercises", force: :cascade do |t|
    t.date "date"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_daily_exercises_on_user_id"
  end

  create_table "exercise_counts", force: :cascade do |t|
    t.integer "daily_exercise_id"
    t.integer "exercise_id"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["daily_exercise_id"], name: "index_exercise_counts_on_daily_exercise_id"
    t.index ["exercise_id"], name: "index_exercise_counts_on_exercise_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.string "exercise_type"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fighters", force: :cascade do |t|
    t.integer "hp"
    t.integer "wins"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_fighters_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "user1_id", null: false
    t.integer "user2_id", null: false
    t.integer "fighter1_id", null: false
    t.integer "fighter2_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fighter1_id"], name: "index_games_on_fighter1_id"
    t.index ["fighter2_id"], name: "index_games_on_fighter2_id"
    t.index ["user1_id"], name: "index_games_on_user1_id"
    t.index ["user2_id"], name: "index_games_on_user2_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "daily_exercises", "users"
  add_foreign_key "fighters", "users"
  add_foreign_key "games", "fighters", column: "fighter1_id"
  add_foreign_key "games", "fighters", column: "fighter2_id"
  add_foreign_key "games", "users", column: "user1_id"
  add_foreign_key "games", "users", column: "user2_id"
end
