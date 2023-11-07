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

ActiveRecord::Schema.define(version: 2023_11_06_064804) do

  create_table "absences", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "shift_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shift_id"], name: "index_absences_on_shift_id", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name", null: false
    t.string "email", null: false
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_admins_on_uid_and_provider", unique: true
  end

  create_table "employees", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name", null: false
    t.string "email", null: false
    t.string "gender"
    t.integer "age"
    t.string "address"
    t.string "phone_number"
    t.string "emergency_phone_number"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_employees_on_confirmation_token", unique: true
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["phone_number"], name: "index_employees_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_employees_on_uid_and_provider", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.boolean "read", default: false, null: false
    t.integer "employee_id"
    t.integer "shift_id"
    t.integer "absence_id"
    t.integer "kind", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["absence_id"], name: "index_notifications_on_absence_id"
    t.index ["employee_id"], name: "index_notifications_on_employee_id"
    t.index ["shift_id"], name: "index_notifications_on_shift_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.integer "status", default: 0
    t.integer "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_shifts_on_employee_id"
  end

  add_foreign_key "absences", "shifts"
  add_foreign_key "notifications", "absences"
  add_foreign_key "notifications", "employees"
  add_foreign_key "notifications", "shifts"
  add_foreign_key "shifts", "employees"
end
