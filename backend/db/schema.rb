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

ActiveRecord::Schema[7.0].define(version: 2023_07_02_091140) do
  create_table "chatrooms", force: :cascade do |t|
    t.string "type"
    t.integer "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friends", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "friend_id"
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_friends_on_member_id"
  end

  create_table "group_members", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "group_id", null: false
    t.string "background"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_members_on_group_id"
    t.index ["member_id"], name: "index_group_members_on_member_id"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "count"
    t.string "name"
    t.string "photo"
    t.string "background"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer "user_id"
    t.string "photo"
    t.string "background"
    t.date "birthday"
    t.string "introduction"
    t.string "email"
    t.string "password"
    t.string "name"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "chatroom_id", null: false
    t.integer "member_id", null: false
    t.string "type"
    t.text "content"
    t.string "photo"
    t.boolean "isPinned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["member_id"], name: "index_messages_on_member_id"
  end

  add_foreign_key "friends", "members"
  add_foreign_key "group_members", "groups"
  add_foreign_key "group_members", "members"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "members"
end
