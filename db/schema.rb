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

ActiveRecord::Schema.define(version: 20181220132712) do

  create_table "accomodations", force: :cascade do |t|
    t.string   "accomodable_type", limit: 255
    t.integer  "accomodable_id",   limit: 4
    t.integer  "tour_id",          limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "nights",           limit: 4
  end

  create_table "agencies", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "tel",              limit: 255
    t.string   "telegram_channel", limit: 255
    t.string   "instagram_page",   limit: 255
    t.text     "address",          limit: 65535
    t.string   "uuid",             limit: 255
    t.integer  "user_id",          limit: 4
    t.string   "subdomain",        limit: 255
    t.string   "mobile",           limit: 255
    t.string   "fax",              limit: 255
    t.string   "email",            limit: 255
    t.text     "about_us",         limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "agencies", ["uuid"], name: "index_agencies_on_uuid", unique: true, using: :btree

  create_table "airlines", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "hotels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "stars",      limit: 4
    t.string   "city",       limit: 255
    t.text     "details",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "price_types", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "pricings", force: :cascade do |t|
    t.integer  "tour_id",       limit: 4
    t.integer  "price_type_id", limit: 4
    t.integer  "value",         limit: 4
    t.integer  "agency_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "railways", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "wagon_type",      limit: 255
    t.integer  "number_of_seats", limit: 4
    t.integer  "agency_id",       limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "tour_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "tour_packages", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "days",       limit: 4
    t.integer  "nights",     limit: 4
    t.text     "details",    limit: 65535
    t.integer  "agency_id",  limit: 4
    t.string   "uuid",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "tour_packages", ["uuid"], name: "index_tour_packages_on_uuid", unique: true, using: :btree

  create_table "tours", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "price",           limit: 4
    t.text     "details",         limit: 65535
    t.integer  "tour_package_id", limit: 4
    t.string   "uuid",            limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "tours", ["uuid"], name: "index_tours_on_uuid", unique: true, using: :btree

  create_table "transportations", force: :cascade do |t|
    t.string   "transportable_type", limit: 255
    t.integer  "transportable_id",   limit: 4
    t.integer  "tour_id",            limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "leg",                limit: 255
  end

  create_table "uploads", force: :cascade do |t|
    t.string   "uploadable_type",         limit: 255
    t.integer  "uploadable_id",           limit: 4
    t.string   "attachment_type",         limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size",    limit: 8
    t.datetime "attachment_updated_at"
  end

  add_index "uploads", ["uploadable_id"], name: "index_uploads_on_uploadable_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
