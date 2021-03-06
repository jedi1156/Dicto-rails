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

ActiveRecord::Schema.define(:version => 20140209224245) do

  create_table "association_types", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "associations", :force => true do |t|
    t.integer  "first_word_id",       :null => false
    t.integer  "second_word_id",      :null => false
    t.integer  "association_type_id", :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "associations", ["first_word_id", "association_type_id"], :name => "index_associations_on_first_word_id_and_association_type_id"
  add_index "associations", ["second_word_id", "association_type_id"], :name => "index_associations_on_second_word_id_and_association_type_id"

  create_table "categories", :force => true do |t|
    t.integer  "word_set_id", :null => false
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "categories", ["parent_id", "word_set_id"], :name => "index_categories_on_parent_id_and_word_set_id"

  create_table "learnts", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.integer  "word_id",                   :null => false
    t.integer  "value",      :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "learnts", ["word_id", "user_id"], :name => "index_learnts_on_word_id_and_user_id", :unique => true

  create_table "meanings", :force => true do |t|
    t.integer  "word_id",    :null => false
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "search_tabs", :force => true do |t|
    t.integer  "user_id",                          :null => false
    t.string   "scheme_prefix", :default => "",    :null => false
    t.string   "scheme_suffix", :default => "",    :null => false
    t.boolean  "open",          :default => false, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "user_word_sets", :force => true do |t|
    t.integer  "user_id",                                   :null => false
    t.integer  "word_set_id",                               :null => false
    t.string   "permissions", :limit => 1, :default => "r", :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "user_word_sets", ["word_set_id", "user_id"], :name => "index_user_word_sets_on_word_set_id_and_user_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "first_name",             :default => "",    :null => false
    t.string   "last_name",              :default => "",    :null => false
    t.boolean  "admin",                  :default => false, :null => false
    t.integer  "learnt_threshold",       :default => 20,    :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "uid"
    t.string   "provider"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "word_categories", :force => true do |t|
    t.integer  "word_id",     :null => false
    t.integer  "category_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "word_categories", ["category_id", "word_id"], :name => "index_word_categories_on_category_id_and_word_id", :unique => true

  create_table "word_sets", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "words", :force => true do |t|
    t.integer  "word_set_id",    :null => false
    t.string   "text",           :null => false
    t.string   "pronounciation"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_foreign_key "associations", "association_types", name: "associations_association_type_id_fk", dependent: :delete
  add_foreign_key "associations", "words", name: "associations_first_word_id_fk", column: "first_word_id", dependent: :delete
  add_foreign_key "associations", "words", name: "associations_second_word_id_fk", column: "second_word_id", dependent: :delete

  add_foreign_key "categories", "categories", name: "categories_parent_id_fk", column: "parent_id", dependent: :delete
  add_foreign_key "categories", "word_sets", name: "categories_word_set_id_fk", dependent: :delete

  add_foreign_key "learnts", "users", name: "learnts_user_id_fk", dependent: :delete
  add_foreign_key "learnts", "words", name: "learnts_word_id_fk", dependent: :delete

  add_foreign_key "meanings", "words", name: "meanings_word_id_fk", dependent: :delete

  add_foreign_key "search_tabs", "users", name: "search_tabs_user_id_fk", dependent: :delete

  add_foreign_key "user_word_sets", "users", name: "user_word_sets_user_id_fk", dependent: :delete
  add_foreign_key "user_word_sets", "word_sets", name: "user_word_sets_word_set_id_fk", dependent: :delete

  add_foreign_key "word_categories", "categories", name: "word_categories_category_id_fk", dependent: :delete
  add_foreign_key "word_categories", "words", name: "word_categories_word_id_fk", dependent: :delete

  add_foreign_key "words", "word_sets", name: "words_word_set_id_fk", dependent: :delete

end
