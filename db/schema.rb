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

ActiveRecord::Schema.define(version: 2018_12_18_091600) do

  create_table "answers", force: :cascade do |t|
    t.text "answer"
    t.boolean "is_optional_answer"
    t.integer "question_id"
    t.integer "answer_id"
    t.integer "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_answers_on_answer_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["survey_id"], name: "index_answers_on_survey_id"
  end

  create_table "question_options", force: :cascade do |t|
    t.text "option"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_options_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "question"
    t.integer "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "type"
    t.boolean "is_optional_question", default: true
    t.index ["survey_id"], name: "index_questions_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
    t.text "name"
    t.index ["link"], name: "index_surveys_on_link", unique: true
    t.index ["user_id"], name: "index_surveys_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firstname"
    t.string "lastname"
    t.boolean "isadmin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
