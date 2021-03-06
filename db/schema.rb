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

ActiveRecord::Schema.define(version: 20150502035649) do

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.string   "background"
    t.string   "personality_traits"
    t.string   "ideals"
    t.string   "bonds"
    t.string   "flaws"
    t.integer  "strength"
    t.integer  "dexterity"
    t.integer  "constitution"
    t.integer  "inteligence"
    t.integer  "wisdom"
    t.integer  "charisma"
    t.integer  "proficiency_bonus"
    t.string   "race"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "current_hp"
    t.integer  "max_hp"
    t.integer  "current_hit_die"
    t.integer  "max_hit_die"
    t.string   "hit_die"
    t.integer  "ac"
    t.integer  "speed"
    t.string   "alignment"
    t.string   "klass"
    t.string   "read_only_slug"
  end

  add_index "characters", ["read_only_slug"], name: "index_characters_on_read_only_slug", unique: true

end
