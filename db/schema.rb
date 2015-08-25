# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150823062736) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_associations", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "department_id"
    t.integer  "semester",      limit: 2
    t.integer  "credit_hour"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "course_associations", ["course_id", "department_id"], name: "index_course_associations_on_course_id_and_department_id", unique: true, using: :btree
  add_index "course_associations", ["course_id"], name: "index_course_associations_on_course_id", using: :btree
  add_index "course_associations", ["department_id"], name: "index_course_associations_on_department_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "code",       limit: 50
    t.string   "name",       limit: 100
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "credits", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "department_id"
    t.integer  "credit_hour"
    t.integer  "int4"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "credits", ["course_id"], name: "index_credits_on_course_id", using: :btree
  add_index "credits", ["department_id"], name: "index_credits_on_department_id", using: :btree

  create_table "departments", force: :cascade do |t|
    t.string   "name",       limit: 100
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "grade_points", force: :cascade do |t|
    t.string   "grade",      limit: 10
    t.integer  "point",      limit: 2
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "marks", force: :cascade do |t|
    t.integer  "internal"
    t.integer  "external"
    t.integer  "total"
    t.string   "grade",        limit: 10
    t.integer  "credit_point"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "student_id"
    t.integer  "course_id"
  end

  add_index "marks", ["course_id"], name: "index_marks_on_course_id", using: :btree
  add_index "marks", ["student_id"], name: "index_marks_on_student_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 50
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "regno",         limit: 50
    t.string   "first_name",    limit: 50
    t.string   "middle_name",   limit: 50
    t.string   "last_name",     limit: 50
    t.string   "email",         limit: 50
    t.text     "address"
    t.integer  "pincode"
    t.string   "emergency_no",  limit: 20
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "department_id"
    t.integer  "state_id"
  end

  add_index "students", ["department_id"], name: "index_students_on_department_id", using: :btree
  add_index "students", ["state_id"], name: "index_students_on_state_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
