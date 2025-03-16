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

ActiveRecord::Schema[8.0].define(version: 2025_03_16_221104) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "exercise_choices", force: :cascade do |t|
    t.bigint "exercise_option_id", null: false
    t.bigint "training_session_id", null: false
    t.integer "reps"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_option_id"], name: "index_exercise_choices_on_exercise_option_id"
    t.index ["training_session_id"], name: "index_exercise_choices_on_training_session_id"
  end

  create_table "exercise_groups", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_exercise_groups_on_user_id"
  end

  create_table "exercise_options", force: :cascade do |t|
    t.bigint "exercise_group_id", null: false
    t.integer "priority"
    t.string "description"
    t.integer "reps"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_group_id", "priority"], name: "index_exercise_options_on_exercise_group_id_and_priority", unique: true
    t.index ["exercise_group_id"], name: "index_exercise_options_on_exercise_group_id"
  end

  create_table "training_sessions", force: :cascade do |t|
    t.date "session_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_training_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "exercise_choices", "exercise_options"
  add_foreign_key "exercise_choices", "training_sessions"
  add_foreign_key "exercise_groups", "users"
  add_foreign_key "exercise_options", "exercise_groups"
  add_foreign_key "training_sessions", "users"
end
