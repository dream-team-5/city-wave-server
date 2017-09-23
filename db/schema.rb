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

ActiveRecord::Schema.define(version: 20170923214737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "places", force: :cascade do |t|
    t.bigint "city_id"
    t.bigint "category_id"
    t.string "name", null: false
    t.string "description", null: false
    t.string "address", null: false
    t.point "location", null: false
    t.string "contacts"
    t.decimal "price"
    t.tstzrange "open_hours"
    t.daterange "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.index ["category_id"], name: "index_places_on_category_id"
    t.index ["city_id"], name: "index_places_on_city_id"
  end

  create_table "places_tags", force: :cascade do |t|
    t.bigint "place_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_places_tags_on_place_id"
    t.index ["tag_id"], name: "index_places_tags_on_tag_id"
  end

  create_table "saved_places", force: :cascade do |t|
    t.bigint "place_id"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_saved_places_on_place_id"
    t.index ["user_id"], name: "index_saved_places_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.integer "roles", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visited_places", force: :cascade do |t|
    t.bigint "place_id"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_visited_places_on_place_id"
    t.index ["user_id"], name: "index_visited_places_on_user_id"
  end

  add_foreign_key "places", "categories"
  add_foreign_key "places", "cities"
  add_foreign_key "places_tags", "places"
  add_foreign_key "places_tags", "tags"
  add_foreign_key "saved_places", "places"
  add_foreign_key "saved_places", "users"
  add_foreign_key "visited_places", "places"
  add_foreign_key "visited_places", "users"
end
