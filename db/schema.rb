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

ActiveRecord::Schema.define(version: 20150318114323) do

  create_table "addresses", force: :cascade do |t|
    t.string   "recipient"
    t.string   "city"
    t.string   "street"
    t.string   "zip_code"
    t.string   "phone"
    t.integer  "user_id"
    t.integer  "status",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["status"], name: "index_addresses_on_status"
  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id"

  create_table "carts", force: :cascade do |t|
    t.integer  "line_items_count", default: 0
    t.integer  "shipment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carts", ["shipment_id"], name: "index_carts_on_shipment_id"
  add_index "carts", ["updated_at"], name: "index_carts_on_updated_at"

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "products_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_translations", force: :cascade do |t|
    t.integer  "category_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
  end

  add_index "category_translations", ["category_id"], name: "index_category_translations_on_category_id"
  add_index "category_translations", ["locale"], name: "index_category_translations_on_locale"
  add_index "category_translations", ["title"], name: "index_category_translations_on_title"

  create_table "line_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "cart_id"
    t.integer  "quantity",                           default: 1
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id"
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id"
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "shipping_address_id"
    t.integer  "billing_address_id"
    t.integer  "shipment_id"
    t.integer  "user_id"
    t.integer  "payment_id"
    t.integer  "status",              default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["billing_address_id"], name: "index_orders_on_billing_address_id"
  add_index "orders", ["payment_id"], name: "index_orders_on_payment_id"
  add_index "orders", ["shipment_id"], name: "index_orders_on_shipment_id"
  add_index "orders", ["shipping_address_id"], name: "index_orders_on_shipping_address_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "payment_translations", force: :cascade do |t|
    t.integer  "payment_id", null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
  end

  add_index "payment_translations", ["locale"], name: "index_payment_translations_on_locale"
  add_index "payment_translations", ["payment_id"], name: "index_payment_translations_on_payment_id"
  add_index "payment_translations", ["title"], name: "index_payment_translations_on_title"

  create_table "payments", force: :cascade do |t|
    t.string "title"
  end

  create_table "product_translations", force: :cascade do |t|
    t.integer  "product_id",  null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.text     "description"
  end

  add_index "product_translations", ["locale"], name: "index_product_translations_on_locale"
  add_index "product_translations", ["product_id"], name: "index_product_translations_on_product_id"
  add_index "product_translations", ["title"], name: "index_product_translations_on_title"

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.string   "ean"
    t.text     "description"
    t.decimal  "price",          precision: 8, scale: 2
    t.string   "image"
    t.integer  "quantity",                               default: 0
    t.integer  "reserved_count",                         default: 0
    t.integer  "sold_count",                             default: 0
    t.integer  "category_id"
    t.integer  "vat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id"
  add_index "products", ["created_at"], name: "index_products_on_created_at"
  add_index "products", ["price"], name: "index_products_on_price"
  add_index "products", ["updated_at"], name: "index_products_on_updated_at"
  add_index "products", ["vat_id"], name: "index_products_on_vat_id"

  create_table "shipment_translations", force: :cascade do |t|
    t.integer  "shipment_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
  end

  add_index "shipment_translations", ["locale"], name: "index_shipment_translations_on_locale"
  add_index "shipment_translations", ["shipment_id"], name: "index_shipment_translations_on_shipment_id"
  add_index "shipment_translations", ["title"], name: "index_shipment_translations_on_title"

  create_table "shipments", force: :cascade do |t|
    t.string  "provider"
    t.string  "title"
    t.decimal "fee",      precision: 8, scale: 2
    t.boolean "default",                          default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "string"
    t.integer  "role"
    t.integer  "integer"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invited_by_id", "invited_by_type"], name: "index_users_on_invited_by_id_and_invited_by_type"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "vats", force: :cascade do |t|
    t.string  "title"
    t.integer "rate"
  end

end
