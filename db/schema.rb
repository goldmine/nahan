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

ActiveRecord::Schema.define(:version => 20111104021513) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "publisher"
    t.text     "desc"
    t.text     "body"
    t.string   "link"
    t.integer  "category_id"
    t.string   "submitted_by"
    t.boolean  "voteble",         :default => true
    t.boolean  "commentable",     :default => true
    t.boolean  "pointable",       :default => true
    t.boolean  "suggestiontable", :default => true
    t.boolean  "visible",         :default => true
    t.integer  "comments_count",  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.integer  "article_id"
    t.integer  "ding_count", :default => 0
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["ancestry"], :name => "index_comments_on_ancestry"

  create_table "folders", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friends", :force => true do |t|
    t.integer  "inviter_id"
    t.integer  "invited_id"
    t.integer  "status",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friends", ["invited_id", "inviter_id"], :name => "index_friends_on_invited_id_and_inviter_id", :unique => true
  add_index "friends", ["inviter_id", "invited_id"], :name => "index_friends_on_inviter_id_and_invited_id", :unique => true

  create_table "links", :force => true do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.string   "url"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_copies", :force => true do |t|
    t.integer  "recipient_id"
    t.integer  "folder_id"
    t.integer  "message_id"
    t.boolean  "is_hide",      :default => false
    t.boolean  "is_read",      :default => false
    t.boolean  "deleted",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "author_id"
    t.string   "subject"
    t.text     "body"
    t.boolean  "is_hide",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "article_id"
    t.string   "comment"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roleuserships", :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_salt"
    t.string   "password_hash"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "enabled",                :default => true
    t.datetime "last_login_at"
    t.integer  "points",                 :default => 0
    t.integer  "v_count",                :default => 0
    t.integer  "p_count",                :default => 0
    t.integer  "s_count",                :default => 0
    t.integer  "c_count",                :default => 0
    t.string   "ip_address"
    t.text     "desc"
    t.string   "name"
    t.string   "education"
    t.string   "location"
    t.string   "age"
    t.string   "gender"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
