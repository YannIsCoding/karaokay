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

ActiveRecord::Schema.define(version: 2019_12_31_155526) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "karaokes", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "location"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "playlist_id"
    t.bigint "user_id"
    t.index ["playlist_id"], name: "index_karaokes_on_playlist_id"
    t.index ["user_id"], name: "index_karaokes_on_user_id"
  end

  create_table "players", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "karaoke_id"
    t.index ["karaoke_id"], name: "index_players_on_karaoke_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.integer "karaoke_id"
    t.integer "song_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string "title"
    t.integer "duration"
    t.string "genre"
    t.string "artist"
    t.string "album_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
  end

  create_table "votes", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "player_id"
    t.bigint "playlist_id"
    t.index ["player_id"], name: "index_votes_on_player_id"
    t.index ["playlist_id"], name: "index_votes_on_playlist_id"
  end

  add_foreign_key "karaokes", "playlists"
  add_foreign_key "karaokes", "users"
  add_foreign_key "players", "karaokes"
  add_foreign_key "players", "users"
  add_foreign_key "votes", "players"
  add_foreign_key "votes", "playlists"
end
