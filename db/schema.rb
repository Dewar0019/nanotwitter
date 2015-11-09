# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151109032603) do

  create_table "favorites", force: :cascade do |t|
    t.integer  "tweet_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorites", ["tweet_id"], name: "index_favorites_on_tweet_id"
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id"

  create_table "follows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "following_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "follows", ["following_id"], name: "index_follows_on_following_id"
  add_index "follows", ["user_id"], name: "index_follows_on_user_id"

  create_table "replies", force: :cascade do |t|
    t.integer  "tweet_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "replies", ["tweet_id"], name: "index_replies_on_tweet_id"
  add_index "replies", ["user_id"], name: "index_replies_on_user_id"

  create_table "retweets", force: :cascade do |t|
    t.integer  "tweet_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "retweets", ["tweet_id"], name: "index_retweets_on_tweet_id"
  add_index "retweets", ["user_id"], name: "index_retweets_on_user_id"

  create_table "tags", force: :cascade do |t|
    t.integer  "tweet_id"
    t.string   "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["tweet_id"], name: "index_tags_on_tweet_id"

  create_table "timelines", force: :cascade do |t|
    t.integer  "tweet_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "timelines", ["tweet_id"], name: "index_timelines_on_tweet_id"
  add_index "timelines", ["user_id"], name: "index_timelines_on_user_id"

  create_table "tweets", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "text"
    t.integer  "retweets_count",  default: 0
    t.integer  "favorites_count", default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "tweets", ["user_id"], name: "index_tweets_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "user_name"
    t.string   "email"
    t.string   "bio"
    t.string   "password_digest"
    t.integer  "tweets_count",     default: 0
    t.integer  "followers_count",  default: 0
    t.integer  "followings_count", default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

end
