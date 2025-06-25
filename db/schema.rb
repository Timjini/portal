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

ActiveRecord::Schema[7.1].define(version: 2025_06_05_151451) do
  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
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

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "answers", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "explination"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "assessments", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "athlete_id", null: false
    t.bigint "coach_id", null: false
    t.text "kpi_data", size: :long, collation: "utf8mb4_bin"
    t.string "recommendation"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_id"], name: "index_assessments_on_athlete_id"
    t.index ["coach_id"], name: "index_assessments_on_coach_id"
    t.check_constraint "json_valid(`kpi_data`)", name: "kpi_data"
  end

  create_table "athlete_level_categories", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "athlete_level_id", null: false
    t.bigint "kpi_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_level_id", "kpi_category_id"], name: "idx_on_athlete_level_id_kpi_category_id_c7c3682592", unique: true
    t.index ["athlete_level_id"], name: "index_athlete_level_categories_on_athlete_level_id"
    t.index ["kpi_category_id"], name: "index_athlete_level_categories_on_kpi_category_id"
  end

  create_table "athlete_levels", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "position", default: 0, null: false
    t.text "description"
    t.integer "min_age"
    t.integer "max_age"
    t.string "color"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_athlete_levels_on_name", unique: true
  end

  create_table "athlete_profiles", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
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

  create_table "attendances", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "attended_at", null: false
    t.string "status", default: "present", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "check_lists", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "title"
    t.bigint "level_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level_id"], name: "index_check_lists_on_level_id"
  end

  create_table "coach_calendars", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_coach_calendars_on_user_id"
  end

  create_table "comments", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "body"
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "dcpa_events", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "title"
    t.string "coach"
    t.text "dates", size: :long, default: "[]", collation: "utf8mb4_bin"
    t.time "time_start"
    t.time "time_end"
    t.string "location"
    t.string "ages_available"
    t.decimal "price", precision: 10
    t.decimal "dcpa_discount", precision: 10
    t.string "extras"
    t.string "event_type"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.check_constraint "json_valid(`dates`)", name: "dates"
  end

  create_table "exercises", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "reps"
    t.integer "sets"
    t.integer "duration_seconds"
    t.float "distance_meters"
    t.string "male_benchmark"
    t.string "female_benchmark"
    t.string "video_url"
    t.integer "position"
    t.string "difficulty_level"
    t.string "intensity"
    t.string "notes"
    t.string "muscle_group"
    t.string "primary_focus"
    t.text "movement_patterns", size: :long, default: "[]", collation: "utf8mb4_bin"
    t.text "equipment", size: :long, default: "[]", collation: "utf8mb4_bin"
    t.text "extra_attributes", size: :long, default: "[]", collation: "utf8mb4_bin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.check_constraint "json_valid(`equipment`)", name: "equipment"
    t.check_constraint "json_valid(`extra_attributes`)", name: "extra_attributes"
    t.check_constraint "json_valid(`movement_patterns`)", name: "movement_patterns"
  end

  create_table "forms", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
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

  create_table "kpi_categories", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levels", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "degree", default: 0
    t.integer "category", default: 0
    t.integer "step"
  end

  create_table "notifications", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "body"
    t.boolean "viewed"
    t.string "notifiable_type", null: false
    t.bigint "notifiable_id", null: false
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable"
  end

  create_table "pricing_packages", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price_per_session", precision: 8, scale: 2
    t.decimal "monthly_fee", precision: 8, scale: 2
    t.string "billing_type", default: "per_session", null: false
    t.integer "sessions_per_month", default: 0, null: false
    t.integer "minimum_commitment_months", default: 0, null: false
    t.boolean "active", default: true, null: false
    t.boolean "requires_commitment", default: false, null: false
    t.boolean "requires_payment_method", default: true, null: false
    t.boolean "requires_approval", default: false, null: false
    t.boolean "requires_contract", default: false, null: false
    t.boolean "requires_terms_of_service", default: true, null: false
    t.boolean "requires_privacy_policy", default: true, null: false
    t.boolean "requires_marketing_consent", default: false, null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "qr_codes", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.boolean "scanned", default: false
    t.string "data"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scanned"], name: "index_qr_codes_on_scanned", unique: true
    t.index ["user_id"], name: "index_qr_codes_on_user_id"
  end

  create_table "questionnaires", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questionnaires_on_user_id"
  end

  create_table "questions", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "content"
    t.string "question_type"
    t.bigint "questionnaire_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "options", size: :long, default: "[]", collation: "utf8mb4_bin"
    t.integer "position"
    t.string "illness_tag"
    t.index ["questionnaire_id"], name: "index_questions_on_questionnaire_id"
    t.check_constraint "json_valid(`options`)", name: "options"
  end

  create_table "reviews", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
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

  create_table "step_exercises", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "step_id", null: false
    t.bigint "exercise_id", null: false
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_step_exercises_on_exercise_id"
    t.index ["step_id", "exercise_id"], name: "index_step_exercises_on_step_id_and_exercise_id", unique: true
    t.index ["step_id"], name: "index_step_exercises_on_step_id"
  end

  create_table "steps", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "athlete_level_category_id", null: false
    t.integer "step_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_level_category_id", "step_number"], name: "index_steps__category_and_number", unique: true
    t.index ["athlete_level_category_id"], name: "index_steps_on_athlete_level_category_id"
  end

  create_table "subscriptions", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "pricing_package_id", null: false
    t.string "status", default: "active", null: false
    t.string "payment_method", null: false
    t.string "billing_cycle", default: "monthly", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "currency", default: "GBP", null: false
    t.string "external_provider", default: "manual", null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pricing_package_id"], name: "index_subscriptions_on_pricing_package_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "taster_session_bookings", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
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

  create_table "time_slots", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "recurrence_rule"
    t.datetime "recurrence_end"
    t.string "slot_type", default: "CoachTimeSlot"
    t.text "group_types", size: :long, default: "[]", collation: "utf8mb4_bin"
    t.string "title"
    t.bigint "coach_calendar_id"
    t.check_constraint "json_valid(`group_types`)", name: "group_types"
  end

  create_table "training_bookings", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
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

  create_table "training_packages", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
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
    t.text "extra", size: :long, default: "{}", null: false, collation: "utf8mb4_bin"
    t.date "start_date"
    t.date "ending_date"
    t.check_constraint "json_valid(`extra`)", name: "extra"
  end

  create_table "user_checklists", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_level_id", null: false
    t.bigint "check_list_id", null: false
    t.bigint "user_id", null: false
    t.boolean "completed", default: false, null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["check_list_id"], name: "index_user_checklists_on_check_list_id"
    t.index ["user_id"], name: "index_user_checklists_on_user_id"
    t.index ["user_level_id"], name: "index_user_checklists_on_user_level_id"
  end

  create_table "user_levels", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "level_id", null: false
    t.string "status", default: "not_started", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "degree"
    t.index ["level_id"], name: "index_user_levels_on_level_id"
    t.index ["user_id"], name: "index_user_levels_on_user_id"
  end

  create_table "user_logins", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "login_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_logins_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
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
  add_foreign_key "assessments", "users", column: "athlete_id"
  add_foreign_key "assessments", "users", column: "coach_id"
  add_foreign_key "athlete_level_categories", "athlete_levels"
  add_foreign_key "athlete_level_categories", "kpi_categories"
  add_foreign_key "athlete_profiles", "users"
  add_foreign_key "attendances", "users"
  add_foreign_key "check_lists", "levels"
  add_foreign_key "coach_calendars", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "qr_codes", "users"
  add_foreign_key "questionnaires", "users"
  add_foreign_key "questions", "questionnaires"
  add_foreign_key "reviews", "users"
  add_foreign_key "reviews", "users", column: "coach_id"
  add_foreign_key "step_exercises", "exercises"
  add_foreign_key "step_exercises", "steps"
  add_foreign_key "steps", "athlete_level_categories"
  add_foreign_key "subscriptions", "pricing_packages"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "taster_session_bookings", "users"
  add_foreign_key "training_bookings", "training_packages"
  add_foreign_key "training_bookings", "users"
  add_foreign_key "user_checklists", "check_lists"
  add_foreign_key "user_checklists", "user_levels"
  add_foreign_key "user_checklists", "users"
  add_foreign_key "user_levels", "levels"
  add_foreign_key "user_levels", "users"
  add_foreign_key "user_logins", "users"
end
