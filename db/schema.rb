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

ActiveRecord::Schema.define(:version => 20130612133938) do

  create_table "answers", :force => true do |t|
    t.text     "answer_text"
    t.integer  "plan_id"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "dmptemplates", :force => true do |t|
    t.string   "template_title"
    t.text     "template_desc"
    t.boolean  "template_published"
    t.integer  "user_id"
    t.integer  "org_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "file_types", :force => true do |t|
    t.string   "file_type_name"
    t.string   "icon_name"
    t.integer  "icon_size"
    t.string   "icon_location"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "file_uploads", :force => true do |t|
    t.string   "file_upload_name"
    t.string   "file_upload_title"
    t.text     "file_upload_desc"
    t.integer  "file_upload_size"
    t.boolean  "file_upload_published"
    t.string   "file_upload_location"
    t.integer  "file_type_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "guidances", :force => true do |t|
    t.text     "guidance_text"
    t.integer  "guidance_file_id"
    t.integer  "org_id"
    t.integer  "theme_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "organisation_types", :force => true do |t|
    t.string   "org_type_name"
    t.text     "org_type_desc"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "organisations", :force => true do |t|
    t.string   "org_name"
    t.string   "org_abbre"
    t.text     "org_desc"
    t.string   "org_target_url"
    t.integer  "org_logo_file_id"
    t.integer  "org_banner_file_id"
    t.integer  "org_type_id"
    t.string   "org_domain"
    t.integer  "org_wayfless_entite"
    t.integer  "org_stylesheet_file_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "pag_title"
    t.text     "pag_body_text"
    t.string   "pag_slug"
    t.integer  "pag_menu"
    t.integer  "pag_menu_position"
    t.string   "pag_target_url"
    t.string   "pag_location"
    t.boolean  "pag_public"
    t.integer  "org_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "phases", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "order"
    t.integer  "dmptemplate_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "phases", ["dmptemplate_id"], :name => "index_phases_on_dmptemplate_id"


  create_table "plan_sections", :force => true do |t|
    t.boolean  "plan_section_edit"
    t.datetime "plan_section_at"
    t.integer  "user_editing_id"
    t.integer  "section_id"
    t.integer  "plan_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "plans", :force => true do |t|
    t.boolean  "plan_locked"
    t.integer  "project_id"
    t.integer  "version_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
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
    t.integer  "org_id"
    t.integer  "project_id"
    t.boolean  "leader_org"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "project_title"
    t.text     "project_note"
    t.boolean  "project_locked"
    t.integer  "dmptemplate_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "question_themes", :force => true do |t|
    t.integer  "question_id"
    t.integer  "theme_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "questions", :force => true do |t|
    t.text     "question_text"
    t.string   "question_type"
    t.text     "question_default_value"
    t.text     "question_suggested_answer"
    t.text     "question_guidance"
    t.integer  "question_order"
    t.integer  "question_parent_id"
    t.integer  "question_dependency_id"
    t.text     "question_dependency_text"
    t.integer  "section_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "sections", :force => true do |t|
    t.string   "section_title"
    t.text     "section_desc"
    t.integer  "section_order"
    t.integer  "version_id"
    t.integer  "org_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "themes", :force => true do |t|
    t.string   "theme_title"
    t.text     "theme_desc"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_org_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "org_id"
    t.integer  "user_role_type_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "user_role_types", :force => true do |t|
    t.string   "user_role_type_name"
    t.text     "user_role_type_desc"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "user_statuses", :force => true do |t|
    t.string   "user_status_name"
    t.text     "user_status_desc"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "user_types", :force => true do |t|
    t.string   "user_type_name"
    t.text     "user_type_desc"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "user_firstname"
    t.string   "user_surname"
    t.string   "user_email"
    t.string   "user_password"
    t.string   "user_orcid_id"
    t.string   "user_shibboleth_id"
    t.integer  "user_type_id"
    t.integer  "user_status_id"
    t.integer  "user_login_count"
    t.datetime "user_last_login"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "versions", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "published"
    t.integer  "order"
    t.integer  "phase_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "versions", ["phase_id"], :name => "index_versions_on_phase_id"

end
