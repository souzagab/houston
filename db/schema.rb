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

ActiveRecord::Schema[7.1].define(version: 2023_11_26_214634) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "cargo_types", ["fuel", "trash", "probe", "satellite"]
  create_enum "mission_status", ["scheduled", "started", "canceled", "failed", "completed"]

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

  create_table "agencies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "missions", force: :cascade do |t|
    t.bigint "planet_id", null: false
    t.bigint "spacecraft_id", null: false
    t.datetime "start_date", null: false
    t.integer "duration", null: false, comment: "Duration in days"
    t.text "description", default: "", null: false
    t.enum "status", default: "scheduled", null: false, enum_type: "mission_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["planet_id"], name: "index_missions_on_planet_id"
    t.index ["spacecraft_id"], name: "index_missions_on_spacecraft_id"
    t.index ["status"], name: "index_missions_on_status"
  end

  create_table "payloads", force: :cascade do |t|
    t.bigint "spacecraft_id", null: false
    t.enum "cargo", null: false, enum_type: "cargo_types"
    t.string "name", null: false
    t.float "weight", null: false, comment: "Cargo weight in Tons (1000kg)"
    t.text "description", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cargo"], name: "index_payloads_on_cargo"
    t.index ["spacecraft_id"], name: "index_payloads_on_spacecraft_id"
  end

  create_table "planets", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "distance_to_earth", null: false, comment: "Distance in megameters (1mm = 1,000,000km)"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spacecrafts", force: :cascade do |t|
    t.bigint "agency_id", null: false
    t.string "type", null: false
    t.string "name", null: false
    t.float "speed", null: false, comment: "Speed in km/h"
    t.integer "remaining_fuel", null: false, comment: "Fuel capacity in days"
    t.integer "crew_capacity", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agency_id"], name: "index_spacecrafts_on_agency_id"
    t.index ["type"], name: "index_spacecrafts_on_type"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "missions", "planets"
  add_foreign_key "missions", "spacecrafts"
  add_foreign_key "payloads", "spacecrafts"
  add_foreign_key "spacecrafts", "agencies"
end
