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

ActiveRecord::Schema.define(:version => 20120816123135) do

  create_table "area_update_download_tasks", :force => true do |t|
    t.string   "image_url_band_3"
    t.integer  "area_update_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "retries",          :default => 0
    t.string   "image_url_band_4"
  end

  add_index "area_update_download_tasks", ["area_update_id"], :name => "index_area_update_download_tasks_on_area_update_id"

  create_table "area_updates", :force => true do |t|
    t.integer  "cloud_cover"
    t.integer  "feed_item_id"
    t.string   "image_url"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "tr_lat"
    t.string   "tr_lon"
    t.string   "tl_lon"
    t.string   "tl_lat"
    t.string   "br_lat"
    t.string   "br_lon"
    t.string   "bl_lat"
    t.string   "bl_lon"
    t.string   "band3_url"
    t.string   "band4_url"
  end

  create_table "areas", :force => true do |t|
    t.integer  "top_lat"
    t.integer  "left_lon"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
    t.string   "name"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "feed_items", :force => true do |t|
    t.string   "title"
    t.string   "link"
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
    t.integer  "area_update_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "x"
    t.integer  "y"
    t.integer  "w"
    t.integer  "h"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "area_id"
    t.integer  "role_id"
    t.text     "description",   :limit => 255
  end

end
