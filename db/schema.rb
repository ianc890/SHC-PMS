# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170424015150) do

  create_table "appointments", force: :cascade do |t|
    t.date     "appointment_date"
    t.time     "appointment_time"
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["patient_id", "doctor_id"], name: "index_appointments_on_patient_id_and_doctor_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "doctors", force: :cascade do |t|
    t.string   "name"
    t.date     "date_of_birth"
    t.string   "job_title"
    t.string   "address"
    t.string   "contact_number"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "picture"
    t.index ["email"], name: "index_doctors_on_email", unique: true
  end

  create_table "hospitals", force: :cascade do |t|
    t.string   "hospital_name"
    t.string   "county"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string   "name"
    t.date     "date_of_birth"
    t.string   "gender"
    t.string   "address"
    t.string   "email"
    t.string   "contact"
    t.integer  "doctor_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["doctor_id", "created_at"], name: "index_patients_on_doctor_id_and_created_at"
    t.index ["doctor_id"], name: "index_patients_on_doctor_id"
  end

  create_table "records", force: :cascade do |t|
    t.text     "reason_for_visit"
    t.text     "infection"
    t.text     "injury"
    t.text     "observations"
    t.text     "medications"
    t.integer  "patient_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["patient_id"], name: "index_records_on_patient_id"
  end

  create_table "referrals", force: :cascade do |t|
    t.integer  "priority"
    t.string   "medical_test"
    t.text     "description"
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "hospital_id"
    t.index ["doctor_id", "created_at"], name: "index_referrals_on_doctor_id_and_created_at"
    t.index ["doctor_id"], name: "index_referrals_on_doctor_id"
    t.index ["hospital_id"], name: "index_referrals_on_hospital_id"
    t.index ["patient_id"], name: "index_referrals_on_patient_id"
  end

end
