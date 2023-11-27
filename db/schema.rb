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

ActiveRecord::Schema[7.1].define(version: 2023_11_24_095403) do
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

  create_table "clinic_dogs", force: :cascade do |t|
    t.boolean "question"
    t.date "dateclinic"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vaccines"
    t.bigint "dog_id", null: false
    t.index ["dog_id"], name: "index_clinic_dogs_on_dog_id"
  end

  create_table "dogs", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "color"
    t.date "birthday"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sex"
    t.integer "breed"
    t.index ["user_id"], name: "index_dogs_on_user_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.date "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "name"
    t.bigint "turn_form_id"
    t.string "description"
    t.bigint "user_id"
    t.bigint "clinic_dog_id"
    t.index ["clinic_dog_id"], name: "index_meetings_on_clinic_dog_id"
    t.index ["turn_form_id"], name: "index_meetings_on_turn_form_id"
    t.index ["user_id"], name: "index_meetings_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.datetime "datetime"
    t.bigint "dog_id"
    t.index ["dog_id"], name: "index_messages_on_dog_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turn_forms", force: :cascade do |t|
    t.string "descriptionCons"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "servicesCons"
    t.bigint "user_id", null: false
    t.date "dateCons"
    t.integer "schedule"
    t.boolean "confirmed", default: false
    t.bigint "dog_id"
    t.decimal "total_amount"
    t.text "vet_description"
    t.date "block_date"
    t.index ["dog_id"], name: "index_turn_forms_on_dog_id"
    t.index ["user_id"], name: "index_turn_forms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dni"
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.integer "role"
    t.decimal "positive_balance", precision: 10, scale: 2, default: "0.0"
    t.index ["dni"], name: "index_users_on_dni", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "clinic_dogs", "dogs"
  add_foreign_key "dogs", "users"
  add_foreign_key "meetings", "clinic_dogs"
  add_foreign_key "meetings", "turn_forms"
  add_foreign_key "meetings", "users"
  add_foreign_key "turn_forms", "dogs"
  add_foreign_key "messages", "dogs"
  add_foreign_key "messages", "users"
  add_foreign_key "turn_forms", "dogs"
  add_foreign_key "turn_forms", "users"
end
