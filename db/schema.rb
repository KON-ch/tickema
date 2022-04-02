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

ActiveRecord::Schema.define(version: 2022_04_02_094605) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customer_stage_histories", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "stage_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id", "stage_id"], name: "index_customer_stage_histories_on_customer_id_and_stage_id"
    t.index ["stage_id", "customer_id"], name: "index_customer_stage_histories_on_stage_id_and_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["name", "user_id"], name: "index_customers_on_name_and_user_id"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.integer "count", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "schedule_id"
    t.bigint "customer_id"
    t.index ["customer_id", "schedule_id"], name: "index_reservations_on_customer_id_and_schedule_id"
    t.index ["schedule_id", "customer_id"], name: "index_reservations_on_schedule_id_and_customer_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.time "staged_at", null: false
    t.date "staged_on", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "stage_id"
    t.index ["stage_id"], name: "index_schedules_on_stage_id"
    t.index ["staged_on", "staged_at"], name: "index_schedules_on_staged_on_and_staged_at"
  end

  create_table "stages", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_stages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "customer_stage_histories", "customers"
  add_foreign_key "customer_stage_histories", "stages"
  add_foreign_key "customers", "users"
  add_foreign_key "reservations", "customers"
  add_foreign_key "reservations", "schedules"
  add_foreign_key "schedules", "stages"
  add_foreign_key "stages", "users"
end
