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

ActiveRecord::Schema[8.0].define(version: 2025_10_06_070321) do
  create_schema "auth"
  create_schema "extensions"
  create_schema "graphql"
  create_schema "graphql_public"
  create_schema "pgbouncer"
  create_schema "realtime"
  create_schema "storage"
  create_schema "vault"

  # These are extensions that must be enabled in order to support this database
  enable_extension "extensions.pg_stat_statements"
  enable_extension "extensions.pgcrypto"
  enable_extension "extensions.uuid-ossp"
  enable_extension "graphql.pg_graphql"
  enable_extension "pg_catalog.plpgsql"
  enable_extension "vault.supabase_vault"

  create_table "artists", force: :cascade do |t|
    t.string "picture_url"
    t.string "spotify_url"
    t.string "apple_url"
    t.string "homepage_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti", unique: true
  end

  create_table "shared_counts", force: :cascade do |t|
    t.string "share_id", null: false
    t.bigint "song_id", null: false
    t.integer "count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["share_id", "song_id"], name: "index_shared_counts_on_share_id_and_song_id", unique: true
    t.index ["song_id"], name: "index_shared_counts_on_song_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "name"
    t.string "source_url"
    t.string "picture_url"
    t.string "spotify_url"
    t.string "apple_url"
    t.bigint "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_songs_on_artist_id"
  end

  create_table "songs_passwords", force: :cascade do |t|
    t.bigint "song_id", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["song_id"], name: "index_songs_passwords_on_song_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "share_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["share_id"], name: "index_users_on_share_id", unique: true
  end

  create_table "users_shared_songs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "song_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["song_id"], name: "index_users_shared_songs_on_song_id"
    t.index ["user_id"], name: "index_users_shared_songs_on_user_id"
  end

  create_table "users_songs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "song_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["song_id"], name: "index_users_songs_on_song_id"
    t.index ["user_id"], name: "index_users_songs_on_user_id"
  end

  add_foreign_key "shared_counts", "songs"
  add_foreign_key "songs", "artists"
  add_foreign_key "songs_passwords", "songs"
  add_foreign_key "users_shared_songs", "songs"
  add_foreign_key "users_shared_songs", "users"
  add_foreign_key "users_songs", "songs"
  add_foreign_key "users_songs", "users"
end
