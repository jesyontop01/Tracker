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

ActiveRecord::Schema.define(version: 2019_01_15_162351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "document_id"
    t.text "status", default: "Posted"
    t.text "reason", default: "Newly Posted"
    t.string "fromOffice"
    t.bigint "office_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status_flag", default: false
    t.index ["document_id"], name: "index_comments_on_document_id"
    t.index ["office_id"], name: "index_comments_on_office_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "series"
    t.string "year"
    t.string "registrationNo"
    t.string "CandidateRange"
    t.text "request"
    t.text "attachment"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string "jti", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "offices", force: :cascade do |t|
    t.string "office_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.bigint "document_id"
    t.string "action", default: "Posted"
    t.text "reason", default: "Newly Posted"
    t.string "arrivalFrom"
    t.string "postedTo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_statuses_on_document_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fullName"
    t.bigint "office_id"
    t.string "api_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["office_id"], name: "index_users_on_office_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "documents"
  add_foreign_key "comments", "offices"
  add_foreign_key "statuses", "documents"
  add_foreign_key "users", "offices"
end
