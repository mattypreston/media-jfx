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

ActiveRecord::Schema.define(:version => 20131030121829) do

  create_table "assets", :force => true do |t|
    t.integer  "package_id"
    t.string   "name"
    t.string   "asset_file"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "media_type",        :limit => 4
    t.boolean  "uploaded_over_api"
    t.string   "directory"
    t.integer  "expected_chunks"
    t.integer  "received_chunks"
  end

  create_table "devices", :force => true do |t|
    t.string   "name"
    t.string   "serial_number"
    t.integer  "site_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "packages", :force => true do |t|
    t.string   "name"
    t.text     "fxml"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "schedules", :force => true do |t|
    t.integer  "device_id"
    t.integer  "package_id"
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "force_flag"
  end

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_line_3"
    t.string   "post_code"
    t.string   "county"
    t.string   "country"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
