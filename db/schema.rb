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

ActiveRecord::Schema.define(:version => 20130708092905) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "answers", :force => true do |t|
    t.text     "text"
    t.integer  "plan_id"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "dmptemplates", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "published"
    t.integer  "user_id"
    t.integer  "organisation_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "locale"
  end

  create_table "file_types", :force => true do |t|
    t.string   "name"
    t.string   "icon_name"
    t.integer  "icon_size"
    t.string   "icon_location"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "file_uploads", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.integer  "size"
    t.boolean  "published"
    t.string   "location"
    t.integer  "file_type_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "guidances", :force => true do |t|
    t.text     "text"
    t.integer  "file_id"
    t.integer  "organisation_id"
    t.integer  "theme_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "organisation_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "organisations", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.text     "description"
    t.string   "target_url"
    t.integer  "logo_file_id"
    t.integer  "banner_file_id"
    t.integer  "organisation_type_id"
    t.string   "domain"
    t.integer  "wayfless_entity"
    t.integer  "stylesheet_file_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body_text"
    t.string   "slug"
    t.integer  "menu"
    t.integer  "menu_position"
    t.string   "target_url"
    t.string   "location"
    t.boolean  "public"
    t.integer  "organisation_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "phases", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "number"
    t.integer  "dmptemplate_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "phases", ["dmptemplate_id"], :name => "index_phases_on_dmptemplate_id"

  create_table "plan_sections", :force => true do |t|
    t.boolean  "edit"
    t.datetime "at"
    t.integer  "user_editing_id"
    t.integer  "section_id"
    t.integer  "plan_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "plans", :force => true do |t|
    t.boolean  "locked"
    t.integer  "project_id"
    t.integer  "version_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "project_groups", :force => true do |t|
    t.boolean  "project_creator"
    t.boolean  "project_editor"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "project_partners", :force => true do |t|
    t.integer  "organisation_id"
    t.integer  "project_id"
    t.boolean  "leader_org"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "note"
    t.boolean  "locked"
    t.integer  "dmptemplate_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "questions", :force => true do |t|
    t.text     "text"
    t.string   "question_type"
    t.text     "default_value"
    t.text     "suggested_answer"
    t.text     "guidance"
    t.integer  "number"
    t.integer  "parent_id"
    t.integer  "dependency_id"
    t.text     "dependency_text"
    t.integer  "section_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "questions_themes", :id => false, :force => true do |t|
    t.integer "question_id", :null => false
    t.integer "theme_id",    :null => false
  end

  add_index "questions_themes", ["question_id", "theme_id"], :name => "index_questions_themes_on_question_id_and_theme_id"

  create_table "sections", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "number"
    t.integer  "version_id"
    t.integer  "organisation_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "themes", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "locale"
  end

  create_table "user_org_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "organisation_id"
    t.integer  "user_role_type_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "user_role_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_statuses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "firstname"
    t.string   "surname"
    t.string   "email"
    t.string   "password"
    t.string   "orcid_id"
    t.string   "shibboleth_id"
    t.integer  "user_type_id"
    t.integer  "user_status_id"
    t.integer  "login_count"
    t.datetime "last_login"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "versions", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "published"
    t.integer  "number"
    t.integer  "phase_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "versions", ["phase_id"], :name => "index_versions_on_phase_id"

end
