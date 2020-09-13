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

ActiveRecord::Schema.define(version: 2020_09_13_141906) do

  create_table "benefits", force: :cascade do |t|
    t.float "cash_back"
    t.string "category"
    t.integer "card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_id"], name: "index_benefits_on_card_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.string "name"
    t.float "amount"
    t.string "month"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_budgets_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "last_digits"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.float "amount"
    t.date "date"
    t.integer "budget_id", null: false
    t.integer "card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["budget_id"], name: "index_purchases_on_budget_id"
    t.index ["card_id"], name: "index_purchases_on_card_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uid"
  end

  add_foreign_key "benefits", "cards"
  add_foreign_key "budgets", "users"
  add_foreign_key "cards", "users"
  add_foreign_key "purchases", "budgets"
  add_foreign_key "purchases", "cards"
end
