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

ActiveRecord::Schema.define(version: 20140428222103) do

  create_table "calendars", force: true do |t|
    t.integer  "anio"
    t.date     "fecha_apertura"
    t.date     "fecha_cierre"
    t.integer  "enterprise_id"
    t.boolean  "status",         default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "calendars", ["anio", "enterprise_id"], name: "index_calendars_on_anio_and_enterprise_id", unique: true

  create_table "departments", force: true do |t|
    t.string   "nombre"
    t.boolean  "status",        default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "enterprise_id"
  end

  create_table "employees", force: true do |t|
    t.string   "nombre"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "role",            default: 1
    t.date     "fecha_alta"
    t.date     "fecha_baja"
    t.boolean  "status",          default: true
    t.string   "cargo"
    t.integer  "department_id"
  end

  add_index "employees", ["email"], name: "index_employees_on_email", unique: true
  add_index "employees", ["remember_token"], name: "index_employees_on_remember_token"

  create_table "enterprises", force: true do |t|
    t.string   "empresa"
    t.boolean  "notif_solicitudes", default: true
    t.boolean  "notif_auditoria",   default: true
    t.boolean  "notif_apertura",    default: true
    t.date     "fecha_baja"
    t.boolean  "status",            default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
