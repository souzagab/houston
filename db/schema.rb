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

ActiveRecord::Schema[7.1].define(version: 2023_11_22_011920) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "mission_status", ["scheduled", "started", "canceled", "failed", "completed"]

  create_table "agencies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "missions", force: :cascade do |t|
    t.bigint "planet_id", null: false
    t.string "spacecraft_type", null: false
    t.bigint "spacecraft_id", null: false
    t.datetime "start_date", null: false
    t.integer "duration", null: false, comment: "Duration in days"
    t.text "description", default: "", null: false
    t.enum "status", default: "scheduled", null: false, enum_type: "mission_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["planet_id"], name: "index_missions_on_planet_id"
    t.index ["spacecraft_type", "spacecraft_id"], name: "index_missions_on_spacecraft"
    t.index ["status"], name: "index_missions_on_status"
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

  add_foreign_key "missions", "planets"
  add_foreign_key "spacecrafts", "agencies"
end
