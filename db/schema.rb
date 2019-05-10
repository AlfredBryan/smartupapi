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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190510082707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_options", force: :cascade do |t|
    t.bigint "question_id"
    t.integer "rank"
    t.text "content"
    t.boolean "correct", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answer_options_on_question_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "answer_option_id"
    t.string "state"
    t.bigint "user_id"
    t.bigint "question_id"
    t.text "content"
    t.string "content_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_option_id"], name: "index_answers_on_answer_option_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "assessments", force: :cascade do |t|
    t.bigint "course_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_assessments_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "description"
    t.bigint "institution_id"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "creator_id"
    t.index ["creator_id"], name: "index_courses_on_creator_id"
    t.index ["institution_id"], name: "index_courses_on_institution_id"
    t.index ["slug"], name: "index_courses_on_slug", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "grading_charts", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "institution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_grading_charts_on_course_id"
    t.index ["institution_id"], name: "index_grading_charts_on_institution_id"
  end

  create_table "grading_scores", force: :cascade do |t|
    t.bigint "grading_chart_id"
    t.string "name"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grading_chart_id"], name: "index_grading_scores_on_grading_chart_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.string "motto"
    t.string "logo_url"
    t.string "email"
    t.string "phone"
    t.string "slug"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_institutions_on_slug", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assessments_id"
    t.index ["assessments_id"], name: "index_questions_on_assessments_id"
    t.index ["topic_id"], name: "index_questions_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.bigint "course_id"
    t.integer "rank"
    t.boolean "active", default: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_topics_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "authentication_token", limit: 30
    t.string "string", limit: 30
    t.string "status", default: "student"
    t.boolean "admin", default: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "surname"
    t.string "address"
    t.string "phone"
    t.string "image_url"
    t.string "state"
    t.datetime "completed_at"
    t.string "sex"
    t.date "date_of_birth"
    t.integer "level", default: 1
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "ward_requests", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "guardian_id"
    t.boolean "approved", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_ward_requests_on_user_id"
  end

  add_foreign_key "answer_options", "questions"
  add_foreign_key "answers", "answer_options"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "assessments", "courses"
  add_foreign_key "courses", "institutions"
  add_foreign_key "courses", "users", column: "creator_id"
  add_foreign_key "grading_charts", "courses"
  add_foreign_key "grading_charts", "institutions"
  add_foreign_key "grading_scores", "grading_charts"
  add_foreign_key "institutions", "users", column: "owner_id"
  add_foreign_key "questions", "assessments", column: "assessments_id"
  add_foreign_key "questions", "topics"
  add_foreign_key "topics", "courses"
  add_foreign_key "ward_requests", "users"
  add_foreign_key "ward_requests", "users", column: "guardian_id"
end
