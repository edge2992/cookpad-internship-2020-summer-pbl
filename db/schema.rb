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

ActiveRecord::Schema.define(version: 2020_08_29_111654) do

  create_table "recipes", force: :cascade do |t|
    t.string "url"
    t.integer "frequency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["url"], name: "index_recipes_on_url", unique: true
  end

  create_table "zoom_recipes", force: :cascade do |t|
    t.integer "zoom_schedule_id"
    t.integer "recipe_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "frequency"
    t.index ["recipe_id"], name: "index_zoom_recipes_on_recipe_id"
    t.index ["zoom_schedule_id"], name: "index_zoom_recipes_on_zoom_schedule_id"
  end

  create_table "zoom_schedules", force: :cascade do |t|
    t.text "text"
    t.string "uuid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
