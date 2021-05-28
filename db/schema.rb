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

ActiveRecord::Schema.define(version: 2021_05_24_091758) do

  create_table "friends", force: :cascade do |t|
    t.integer "user_id"
    t.integer "f_id"
    t.boolean "accept", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "group_messages", force: :cascade do |t|
    t.string "groupname"
    t.integer "groupadmin_id"
    t.boolean "bilateral", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.integer "user_id"
    t.integer "group_message_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "initiate", default: false
  end

  create_table "posts", force: :cascade do |t|
    t.text "body"
    t.integer "user_id"
    t.string "view"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.text "about", default: "Newly joined"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["username", "email"], name: "index_users_on_username_and_email", unique: true
  end

  add_foreign_key "friends", "users", column: "f_id", on_delete: :cascade
  add_foreign_key "friends", "users", on_delete: :cascade
  add_foreign_key "group_messages", "users", column: "groupadmin_id", on_delete: :nullify
  add_foreign_key "messages", "group_messages", on_delete: :cascade
  add_foreign_key "messages", "users", on_delete: :cascade
  add_foreign_key "posts", "users", on_delete: :cascade
end
