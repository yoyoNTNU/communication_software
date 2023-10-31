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

ActiveRecord::Schema[7.0].define(version: 2023_10_31_034716) do
  create_table "chatroom_members", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "chatroom_id", null: false
    t.string "background"
    t.boolean "isPinned", default: false
    t.boolean "isDisabled", default: true
    t.boolean "isMuted", default: false
    t.datetime "delete_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_chatroom_members_on_chatroom_id"
    t.index ["member_id"], name: "index_chatroom_members_on_member_id"
  end

  create_table "chatrooms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "type_"
    t.integer "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friend_requests", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "friend_id", null: false
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friend_requests_on_friend_id"
    t.index ["member_id"], name: "index_friend_requests_on_member_id"
  end

  create_table "friendships", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "friend_id", null: false
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["member_id"], name: "index_friendships_on_member_id"
  end

  create_table "groups", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "photo"
    t.string "background"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
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
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "user_id"
    t.string "email"
    t.string "photo"
    t.string "background"
    t.date "birthday"
    t.string "introduction"
    t.string "name"
    t.string "phone"
    t.boolean "is_login_mail", default: true
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_members_on_confirmation_token", unique: true
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_members_on_uid_and_provider", unique: true
  end

  create_table "message_readers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "message_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_message_readers_on_member_id"
    t.index ["message_id"], name: "index_message_readers_on_message_id"
  end

  create_table "messages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "chatroom_id", null: false
    t.bigint "member_id", null: false
    t.string "type_"
    t.text "content"
    t.string "file"
    t.boolean "isPinned", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "reply_to_id"
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["member_id"], name: "index_messages_on_member_id"
    t.index ["reply_to_id"], name: "index_messages_on_reply_to_id"
  end

  add_foreign_key "chatroom_members", "chatrooms"
  add_foreign_key "chatroom_members", "members"
  add_foreign_key "friend_requests", "members"
  add_foreign_key "friend_requests", "members", column: "friend_id"
  add_foreign_key "friendships", "members"
  add_foreign_key "friendships", "members", column: "friend_id"
  add_foreign_key "message_readers", "members"
  add_foreign_key "message_readers", "messages"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "members"
  add_foreign_key "messages", "messages", column: "reply_to_id"
end
