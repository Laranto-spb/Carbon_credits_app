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

ActiveRecord::Schema[8.1].define(version: 2026_07_06_133051) do
  create_table "carbon_projects", force: :cascade do |t|
    t.string "country", null: false
    t.datetime "created_at", null: false
    t.date "crediting_period_end"
    t.date "crediting_period_start"
    t.datetime "last_synced_at"
    t.string "methodology"
    t.string "name", null: false
    t.string "project_developer"
    t.string "project_id", null: false
    t.string "region", null: false
    t.string "registry", null: false
    t.string "status"
    t.decimal "total_credits_issued", precision: 18, scale: 4
    t.datetime "updated_at", null: false
    t.string "validator"
    t.index ["country", "status"], name: "index_carbon_projects_on_country_and_status"
    t.index ["project_id"], name: "index_carbon_projects_on_project_id", unique: true
  end
end
