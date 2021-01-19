# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_19_212238) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "exchanges", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.string "country", null: false
    t.string "details", null: false
    t.string "department", null: false
    t.boolean "is_matching_viewable", default: false, null: false
  end

  create_table "participation_token", force: :cascade do |t|
    t.datetime "expires_at", null: false
    t.string "token", null: false
    t.string "user_id", null: false
  end

  create_table "participations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "shipped", default: false
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "country"
    t.string "preferences"
    t.string "team"
    t.string "full_name"
    t.uuid "match_participation_id"
    t.uuid "user_id"
    t.uuid "exchange_id"
    t.boolean "is_matched", default: false, null: false
    t.index ["exchange_id"], name: "index_participations_on_exchange_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "participations", "exchanges"
  add_foreign_key "participations", "users"
end
