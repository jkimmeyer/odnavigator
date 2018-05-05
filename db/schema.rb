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

ActiveRecord::Schema.define(version: 20180505115306) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "federal_state_id"
    t.json "feature"
    t.string "debkg_id"
    t.index ["federal_state_id"], name: "index_cities_on_federal_state_id"
  end

  create_table "cities_federal_states", id: false, force: :cascade do |t|
    t.bigint "federal_state_id", null: false
    t.bigint "city_id", null: false
  end

  create_table "city_portals", force: :cascade do |t|
    t.bigint "city_id"
    t.integer "data_portal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "city_snapshot_metrics", primary_key: ["city_id", "ref_date"], force: :cascade do |t|
    t.bigint "city_id", null: false
    t.datetime "ref_date", null: false
    t.integer "sum_of_datasets"
    t.decimal "total_quality"
    t.decimal "format_quality"
    t.decimal "openness_quality"
    t.decimal "completeness_quality"
    t.json "category_counts"
    t.decimal "access_quality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_city_snapshot_metrics_on_city_id"
  end

  create_table "data_portals", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.string "description"
    t.string "status"
    t.boolean "avaiability"
    t.string "search_param"
    t.decimal "quality"
    t.integer "sum_of_datasets"
    t.decimal "format_quality"
    t.decimal "openness_quality"
    t.decimal "access_quality"
    t.decimal "completeness_quality"
    t.json "category_counts"
  end

  create_table "data_resources", force: :cascade do |t|
    t.string "unique_identifier"
    t.string "title"
    t.string "format"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "dataset_id"
    t.datetime "metadata_created"
    t.datetime "metadata_modified"
    t.index ["dataset_id"], name: "index_data_resources_on_dataset_id"
  end

  create_table "datasets", force: :cascade do |t|
    t.string "unique_identifier"
    t.text "category", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "url"
    t.decimal "quality"
    t.string "package_search_title"
    t.bigint "city_portal_id"
    t.text "missing_keys", default: [], array: true
    t.string "maintainer"
    t.string "license"
    t.decimal "completeness"
    t.datetime "metadata_created"
    t.datetime "metadata_modified"
    t.index ["city_portal_id"], name: "index_datasets_on_city_portal_id"
  end

  create_table "federal_states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "feature"
    t.string "debkg_id"
  end

  add_foreign_key "cities", "federal_states"
end
