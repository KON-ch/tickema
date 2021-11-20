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

ActiveRecord::Schema.define(version: 2021_11_20_051711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.bigint "ticket_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "index_contacts_on_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["id", "user_id"], name: "index_customers_on_id_and_user_id"
    t.index ["id"], name: "index_customers_on_id"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.time "staged_at", null: false
    t.date "staged_on", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "stage_id"
    t.index ["stage_id"], name: "index_schedules_on_stage_id"
    t.index ["staged_at", "staged_on"], name: "index_schedules_on_staged_at_and_staged_on", unique: true
    t.index ["staged_at"], name: "index_schedules_on_staged_at"
    t.index ["staged_on"], name: "index_schedules_on_staged_on"
  end

  create_table "stages", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "index_stages_on_id"
    t.index ["title"], name: "index_stages_on_title", unique: true
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "stage_id", null: false
    t.bigint "schedule_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "count", default: 1, null: false
    t.index ["id"], name: "index_tickets_on_id"
    t.index ["stage_id", "schedule_id", "customer_id"], name: "index_tickets_on_stage_id_and_schedule_id_and_customer_id", unique: true
  end

  create_table "user_stages", force: :cascade do |t|
    t.bigint "stage_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stage_id", "user_id"], name: "index_user_stages_on_stage_id_and_user_id", unique: true
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

  add_foreign_key "contacts", "tickets"
  add_foreign_key "contacts", "users"
  add_foreign_key "customers", "users"
  add_foreign_key "schedules", "stages"
  add_foreign_key "tickets", "customers"
  add_foreign_key "tickets", "schedules"
  add_foreign_key "tickets", "stages"
  add_foreign_key "user_stages", "stages"
  add_foreign_key "user_stages", "users"
end
