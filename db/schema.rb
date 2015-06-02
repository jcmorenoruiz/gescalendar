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

ActiveRecord::Schema.define(version: 20150601130642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.date     "desde"
    t.date     "hasta"
    t.integer  "num_min_emp"
    t.boolean  "status",                    default: true
    t.string   "cargo",         limit: 255
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notas"
  end

  create_table "calendars", force: :cascade do |t|
    t.integer  "anio"
    t.date     "fecha_apertura"
    t.date     "fecha_cierre"
    t.integer  "department_id"
    t.boolean  "status",         default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "d1",             default: true
    t.boolean  "d2",             default: true
    t.boolean  "d3",             default: true
    t.boolean  "d4",             default: true
    t.boolean  "d5",             default: true
    t.boolean  "d6",             default: true
    t.boolean  "d7",             default: true
  end

  add_index "calendars", ["anio", "department_id"], name: "index_calendars_on_anio_and_department_id", unique: true, using: :btree

  create_table "default_calendars", force: :cascade do |t|
    t.integer  "anio"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "default_calendars", ["anio"], name: "index_default_calendars_on_anio", unique: true, using: :btree

  create_table "default_line_calendars", force: :cascade do |t|
    t.date     "fecha"
    t.string   "nombre",              limit: 255
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "default_calendar_id"
  end

  add_index "default_line_calendars", ["fecha", "default_calendar_id"], name: "index_default_line_calendars_on_fecha_and_default_calendar_id", unique: true, using: :btree

  create_table "default_request_types", force: :cascade do |t|
    t.string   "nombre",       limit: 255
    t.integer  "num_dias_max"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: :cascade do |t|
    t.string   "nombre",        limit: 255
    t.boolean  "status",                    default: true
    t.integer  "enterprise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "jefe_auditor",              default: true
  end

  create_table "departments_request_types", force: :cascade do |t|
    t.integer  "num_max_dias"
    t.integer  "request_type_id"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "departments_request_types", ["department_id", "request_type_id"], name: "departments_request_types_index", unique: true, using: :btree
  add_index "departments_request_types", ["department_id"], name: "index_departments_request_types_on_department_id", using: :btree
  add_index "departments_request_types", ["request_type_id"], name: "index_departments_request_types_on_request_type_id", using: :btree

  create_table "employees", force: :cascade do |t|
    t.string   "nombre",          limit: 255
    t.string   "email",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest", limit: 255
    t.string   "remember_token",  limit: 255
    t.integer  "role",                        default: 1
    t.date     "fecha_alta"
    t.date     "fecha_baja"
    t.boolean  "status",                      default: true
    t.string   "cargo",           limit: 255
    t.integer  "department_id"
  end

  add_index "employees", ["email"], name: "index_employees_on_email", unique: true, using: :btree
  add_index "employees", ["remember_token"], name: "index_employees_on_remember_token", using: :btree

  create_table "enterprises", force: :cascade do |t|
    t.string   "empresa",           limit: 255
    t.boolean  "notif_solicitudes",             default: true
    t.boolean  "notif_auditoria",               default: true
    t.boolean  "notif_apertura",                default: true
    t.date     "fecha_baja"
    t.boolean  "status",                        default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country",           limit: 255
  end

  create_table "line_calendars", force: :cascade do |t|
    t.date     "fecha"
    t.string   "dia",         limit: 255
    t.string   "desc",        limit: 255
    t.integer  "calendar_id"
    t.boolean  "status",                  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "request_types", force: :cascade do |t|
    t.string   "nombre",        limit: 255
    t.integer  "num_dias_max"
    t.boolean  "status",                    default: true
    t.integer  "enterprise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "tipo",                      default: true
    t.string   "color",         limit: 255
  end

  create_table "requests", force: :cascade do |t|
    t.string   "motivo",          limit: 255
    t.string   "motivo_rev",      limit: 255
    t.date     "desde"
    t.date     "hasta"
    t.integer  "status",                      default: 1
    t.integer  "request_type_id"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "requests", "employees"
  add_foreign_key "requests", "request_types"
end
