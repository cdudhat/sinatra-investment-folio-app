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

ActiveRecord::Schema.define(version: 20170305030117) do

  create_table "funds", force: :cascade do |t|
    t.string  "name"
    t.string  "category"
    t.decimal "value",    precision: 18, scale: 2
    t.integer "user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string  "name"
    t.string  "category"
    t.decimal "value",    precision: 18, scale: 2
    t.integer "user_id"
  end

  create_table "propertys", force: :cascade do |t|
    t.string  "name"
    t.string  "category"
    t.decimal "value",    precision: 18, scale: 2
    t.integer "user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string  "name"
    t.decimal "price",   precision: 8,  scale: 2
    t.integer "number"
    t.decimal "value",   precision: 18, scale: 2
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string  "name"
    t.string  "email"
    t.string  "password_digest"
    t.decimal "total_value",     precision: 18, scale: 2
  end

end
