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

ActiveRecord::Schema[7.1].define(version: 2025_11_24_122921) do
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

  create_table "app_errors", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "error_type"
    t.text "message"
    t.text "backtrace"
    t.datetime "occurred_at"
    t.text "context", size: :long, collation: "utf8mb4_bin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.check_constraint "json_valid(`context`)", name: "context"
  end

  create_table "assessment_checklists", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "assessment_id", null: false
    t.bigint "check_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id", "check_list_id"], name: "index_assessment_checklists_on_assessment_id_and_check_list_id", unique: true
    t.index ["check_list_id"], name: "fk_rails_ae2f0861b9"
  end

  create_table "assessments", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "athlete_id", null: false
    t.bigint "coach_id", null: false
    t.text "kpi_data", size: :medium, collation: "utf8mb4_bin"
    t.string "recommendation"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed", default: false, null: false
    t.datetime "completed_at"
    t.bigint "level_id", null: false
    t.index ["athlete_id"], name: "index_assessments_on_athlete_id"
    t.index ["coach_id"], name: "index_assessments_on_coach_id"
    t.index ["completed"], name: "index_assessments_on_completed"
    t.index ["level_id"], name: "index_assessments_on_level_id"
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

