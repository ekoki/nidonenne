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

ActiveRecord::Schema[7.0].define(version: 2023_06_20_044137) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "got_ups", force: :cascade do |t|
    t.boolean "got_up", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.datetime "start_time"
    t.index ["user_id"], name: "index_got_ups_on_user_id"
  end

  create_table "line_users", force: :cascade do |t|
    t.string "line_user_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_line_users_on_user_id"
  end

  create_table "notification_settings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "send_daily", default: false, null: false
    t.datetime "send_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notification_settings_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "question", null: false
    t.text "answer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "send_daily_time"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "auth_token"
    t.datetime "auth_token_created_at"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "got_ups", "users"
  add_foreign_key "line_users", "users"
  add_foreign_key "notification_settings", "users"
  add_foreign_key "questions", "users"
  add_foreign_key "schedules", "users"
end
