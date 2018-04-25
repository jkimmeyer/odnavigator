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

ActiveRecord::Schema.define(version: 20180425202335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "url", null: false
    t.bigint "data_portal_id"
    t.index ["data_portal_id"], name: "index_api_requests_on_data_portal_id"
    t.index ["url"], name: "index_api_requests_on_url", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "federal_state_id"
    t.integer "quality"
    t.index ["federal_state_id"], name: "index_cities_on_federal_state_id"
  end

  create_table "cities_counties", id: false, force: :cascade do |t|
    t.bigint "federal_state_id", null: false
    t.bigint "city_id", null: false
  end

  create_table "city_features", force: :cascade do |t|
    t.json "feature"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "debkg_id"
    t.index ["city_id"], name: "index_city_features_on_city_id"
  end

  create_table "city_portals", force: :cascade do |t|
    t.bigint "city_id"
    t.integer "data_portal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "city_snapshot_metrics", primary_key: ["city_id", "date"], force: :cascade do |t|
    t.bigint "city_id", null: false
    t.date "date", null: false
    t.integer "sum_of_datasets"
    t.float "total_quality"
    t.float "format_quality"
    t.float "openness_quality"
    t.float "completeness_quality"
    t.json "category_counts"
    t.float "access_quality"
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
    t.string "version"
    t.string "status"
    t.boolean "avaiability"
    t.string "search_param"
    t.string "result_store_key"
    t.string "category_key"
    t.integer "quality"
    t.bigint "api_request_id"
    t.index ["api_request_id"], name: "index_data_portals_on_api_request_id"
  end

  create_table "data_resources", force: :cascade do |t|
    t.string "data_resources_id"
    t.string "title"
    t.string "url"
    t.bigint "datasets_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "formats", default: [], array: true
    t.integer "year"
    t.string "licenses", default: [], array: true
    t.bigint "dataset_id"
    t.index ["datasets_id"], name: "index_data_resources_on_datasets_id"
  end

  create_table "datasets", force: :cascade do |t|
    t.string "dataset_id"
    t.text "category", default: [], array: true
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "url"
    t.integer "quality"
    t.text "missing_keys", default: [], array: true
    t.index ["city_id"], name: "index_datasets_on_city_id"
  end

  create_table "feature_collections", force: :cascade do |t|
    t.json "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "referencing"
  end

  create_table "federal_state_features", force: :cascade do |t|
    t.json "feature"
    t.bigint "federal_state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "debkg_id"
    t.index ["federal_state_id"], name: "index_federal_state_features_on_federal_state_id"
  end

  create_table "federal_states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cities", "federal_states"
  add_foreign_key "datasets", "cities"
end
