# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 999) do

  create_table "addresses", :force => true do |t|
    t.string  "street_address_line_one"
    t.string  "street_address_line_two"
    t.string  "city"
    t.string  "state"
    t.string  "postal_code"
    t.string  "country"
    t.integer "addressable_id"
    t.string  "addressable_type"
  end

  create_table "clinical_documents", :force => true do |t|
    t.integer "size"
    t.string  "content_type"
    t.string  "filename"
    t.string  "doc_type"
    t.integer "vendor_test_plan_id"
  end

  create_table "document_locations", :force => true do |t|
    t.string "name",             :limit => 100
    t.string "xpath_expression", :limit => 400
    t.text   "description"
    t.string "doc_type",         :limit => 10
    t.string "section",          :limit => 30
    t.string "subsection",       :limit => 30
  end

  create_table "languages", :force => true do |t|
    t.string  "language"
    t.string  "mode"
    t.boolean "preference"
    t.integer "patient_data_id", :null => false
  end

  create_table "namespaces", :force => true do |t|
    t.string  "prefix"
    t.string  "uri"
    t.integer "document_location_id", :null => false
  end

  create_table "patient_data", :force => true do |t|
    t.string  "name"
    t.integer "vendor_test_plan_id"
  end

  create_table "person_names", :force => true do |t|
    t.string  "name_prefix"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "name_suffix"
    t.integer "nameable_id"
    t.string  "nameable_type"
  end

  create_table "registration_information", :force => true do |t|
    t.string  "person_identifier"
    t.date    "birth_date"
    t.string  "gender"
    t.string  "marital_status"
    t.string  "religious_affiliation"
    t.string  "race"
    t.string  "ethnicity"
    t.integer "patient_data_id",       :null => false
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "supports", :force => true do |t|
    t.date    "start_support"
    t.date    "end_support"
    t.string  "contact_relationship"
    t.string  "contact_type"
    t.integer "patient_data_id",      :null => false
  end

  create_table "telecoms", :force => true do |t|
    t.string  "home_phone"
    t.string  "work_phone"
    t.string  "mobile_phone"
    t.string  "vacation_home_phone"
    t.string  "email"
    t.string  "url"
    t.integer "reachable_id"
    t.string  "reachable_type"
  end

  create_table "user_roles", :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.boolean  "terms_of_service"
    t.boolean  "send_updates"
    t.integer  "role_id"
    t.string   "password_reset_code",       :limit => 40
  end

  create_table "vendor_test_plans", :force => true do |t|
    t.integer  "vendor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors", :force => true do |t|
    t.string "display_name"
  end

end
