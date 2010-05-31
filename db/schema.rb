# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "voters", :force => true do |t|
    t.string   "name_last"
    t.string   "name_first"
    t.string   "email"
    t.integer  "street_no"
    t.string   "street_dir"
    t.string   "street_name"
    t.string   "street_type"
    t.string   "apt"
    t.string   "apt_no"
    t.string   "city"
    t.string   "zip"
    t.string   "precinct",     :limit => 2
    t.integer  "age"
    t.string   "phone"
    t.string   "phone_tmp"
    t.string   "text_message"
    t.string   "do_not_call"
    t.string   "contacted"
    t.string   "literature"
    t.string   "suf"
    t.string   "ys"
    t.string   "volunteer"
    t.string   "donations"
    t.string   "newreg"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
