class RepairDb < ActiveRecord::Migration
  def up

    create_table "comments", :force => true do |t|
    t.string    "code"
    t.string    "author"
    t.string    "author_email"
    t.text      "content"
    t.integer   "message_id"
    t.integer   "user_id"
    t.string    "permalink"
    t.string    "user_ip"
    t.string    "user_agent"
    t.string    "referrer"
    t.string    "comment_type"
    t.string    "author_url"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "games", :force => true do |t|
    t.string   "asin"
    t.integer  "user_id"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "impressions", :force => true do |t|
    t.string    "impressionable_type"
    t.integer   "impressionable_id"
    t.integer   "user_id"
    t.string    "controller_name"
    t.string    "action_name"
    t.string    "view_name"
    t.string    "request_hash"
    t.string    "ip_address"
    t.string    "session_hash"
    t.text      "message"
    t.text      "referrer"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], :name => "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], :name => "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], :name => "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], :name => "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], :name => "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], :name => "poly_session_index"
  add_index "impressions", ["user_id"], :name => "index_impressions_on_user_id"

  create_table "messages", :force => true do |t|
    t.string   "pickUpCode"
    t.text     "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password"
    t.integer  "user_id"
    t.boolean  "display_fc",    :default => true
    t.boolean  "display_games", :default => true
  end

  add_index "messages", ["pickUpCode"], :name => "index_messages_on_pickUpCode"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "profiles", :force => true do |t|
    t.integer   "message_count"
    t.string    "friend_code"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "user_id"
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
    t.timestamp "password_reset_sent_at"
    t.boolean   "comment_alert",            :default => false
    t.string    "profile_pic_file_name"
    t.string    "profile_pic_content_type"
    t.integer   "profile_pic_file_size"
    t.datetime  "profile_pic_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  end

  def down
  end
end
