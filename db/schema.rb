# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_02_21_184843) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "explination"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "athlete_profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.string "height"
    t.string "weight"
    t.string "email"
    t.string "phone"
    t.string "school_name"
    t.string "address"
    t.string "city"
    t.string "power_of_ten"
    t.integer "level"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "child_password"
    t.index ["user_id"], name: "index_athlete_profiles_on_user_id"
  end

  create_table "check_lists", force: :cascade do |t|
    t.string "title"
    t.bigint "level_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level_id"], name: "index_check_lists_on_level_id"
  end

  create_table "coach_calendars", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_coach_calendars_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "dcpa_events", force: :cascade do |t|
    t.string "title"
    t.string "coach"
    t.date "dates", default: [], array: true
    t.time "time_start"
    t.time "time_end"
    t.string "location"
    t.string "ages_available"
    t.decimal "price"
    t.decimal "dcpa_discount"
    t.string "extras"
    t.string "event_type"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forms", force: :cascade do |t|
    t.string "email", null: false
    t.string "title"
    t.string "name", null: false
    t.string "phone", null: false
    t.string "subject"
    t.string "status"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levels", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "degree", default: 0
    t.integer "category", default: 0
    t.integer "step"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "body"
    t.boolean "viewed"
    t.string "notifiable_type", null: false
    t.bigint "notifiable_id", null: false
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable"
  end

  create_table "qr_codes", force: :cascade do |t|
    t.boolean "scanned", default: false
    t.string "data"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scanned"], name: "index_qr_codes_on_scanned", unique: true
    t.index ["user_id"], name: "index_qr_codes_on_user_id"
  end

  create_table "questionnaires", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questionnaires_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "content"
    t.string "question_type"
    t.bigint "questionnaire_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "options", default: [], array: true
    t.integer "position"
    t.string "illness_tag"
    t.index ["questionnaire_id"], name: "index_questions_on_questionnaire_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "coach_id", null: false
    t.text "comment", null: false
    t.string "reviewable_type", null: false
    t.bigint "reviewable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coach_id"], name: "index_reviews_on_coach_id"
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "taster_session_bookings", force: :cascade do |t|
    t.bigint "user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "athlete_full_name"
    t.string "email"
    t.string "phone"
    t.string "role"
    t.date "birth_date"
    t.date "taster_session_date"
    t.text "health_issues"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_taster_session_bookings_on_user_id"
  end

  create_table "time_slots", force: :cascade do |t|
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "recurrence_rule"
    t.datetime "recurrence_end"
    t.string "slot_type", default: "CoachTimeSlot"
    t.text "coach_calendar_ids", default: [], array: true
    t.text "group_types", default: [], array: true
    t.string "title"
  end

  create_table "training_bookings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "training_package_id"
    t.string "first_name"
    t.string "last_name"
    t.string "athlete_full_name"
    t.string "email"
    t.string "phone"
    t.text "address"
    t.string "role"
    t.date "birth_date"
    t.text "health_issues"
    t.string "training_package_name"
    t.string "approval_status", default: "pending"
    t.string "payment_status", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_package_id"], name: "index_training_bookings_on_training_package_id"
    t.index ["user_id"], name: "index_training_bookings_on_user_id"
  end

  create_table "training_packages", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.text "features"
    t.decimal "price", precision: 10, scale: 2
    t.integer "duration_in_days"
    t.string "package_type", default: "group_training"
    t.string "training_type", default: "group_training"
    t.string "duration", default: "month"
    t.string "status", default: "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "extra", default: {}, null: false
    t.index ["extra"], name: "index_training_packages_on_extra", using: :gin
  end

  create_table "user_checklists", force: :cascade do |t|
    t.bigint "user_level_id", null: false
    t.bigint "check_list_id", null: false
    t.bigint "user_id", null: false
    t.boolean "completed"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["check_list_id"], name: "index_user_checklists_on_check_list_id"
    t.index ["user_id"], name: "index_user_checklists_on_user_id"
    t.index ["user_level_id"], name: "index_user_checklists_on_user_level_id"
  end

  create_table "user_levels", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "level_id", null: false
    t.string "status", default: "not_started", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "degree"
    t.index ["level_id"], name: "index_user_levels_on_level_id"
    t.index ["user_id"], name: "index_user_levels_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "role", default: "athlete"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.string "address"
    t.string "parent_id"
    t.string "auth_token"
    t.string "apple_id"
    t.string "google_id"
    t.string "color"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "athlete_profiles", "users"
  add_foreign_key "check_lists", "levels"
  add_foreign_key "coach_calendars", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "qr_codes", "users"
  add_foreign_key "questionnaires", "users"
  add_foreign_key "questions", "questionnaires"
  add_foreign_key "reviews", "users"
  add_foreign_key "reviews", "users", column: "coach_id"
  add_foreign_key "taster_session_bookings", "users"
  add_foreign_key "training_bookings", "training_packages"
  add_foreign_key "training_bookings", "users"
  add_foreign_key "user_checklists", "check_lists"
  add_foreign_key "user_checklists", "user_levels"
  add_foreign_key "user_checklists", "users"
  add_foreign_key "user_levels", "levels"
  add_foreign_key "user_levels", "users"
end
