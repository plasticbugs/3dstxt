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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120211081213) do

  create_table "messages", :force => true do |t|
    t.string    "pickUpCode"
    t.text      "contents"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "password"
    t.integer   "user_id"
  end

  add_index "messages", ["pickUpCode"], :name => "index_messages_on_pickUpCode"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "profiles", :force => true do |t|
    t.integer  "message_count"
    t.string   "friend_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string    "name"
    t.string    "friend_code"
    t.string    "email"
    t.string    "encrypted_password"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "salt"
    t.string    "password_reset_token"
    t.datetime  "password_reset_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
