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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120713014341) do

  create_table "area_updates", :force => true do |t|
    t.integer  "tl_lat"
    t.integer  "tl_long"
    t.integer  "cloud_cover"
    t.integer  "feed_item_id"
    t.string   "image_url"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "feed_items", :force => true do |t|
    t.string   "title"
    t.integer  "feed_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "feeds", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "intersections", :force => true do |t|
    t.boolean  "reported"
    t.integer  "area_id"
    t.integer  "area_updated_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "volunteers", :force => true do |t|
    t.integer "user_id"
    t.integer "area_id"
  end

end
