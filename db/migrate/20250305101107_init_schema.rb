# frozen_string_literal: true

class InitSchema < ActiveRecord::Migration[7.0]
  def up
    # These are extensions that must be enabled in order to support this database
    enable_extension "plpgsql"
    create_table "active_storage_attachments" do |t|
      t.string "name", null: false
      t.string "record_type", null: false
      t.bigint "record_id", null: false
      t.bigint "blob_id", null: false
      t.datetime "created_at", null: false
      t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
      t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
    end
    create_table "active_storage_blobs" do |t|
      t.string "key", null: false
      t.string "filename", null: false
      t.string "content_type"
      t.text "metadata"
      t.string "service_name", null: false
      t.bigint "byte_size", null: false
      t.string "checksum"
      t.datetime "created_at", null: false
      t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
    end
    create_table "active_storage_variant_records" do |t|
      t.bigint "blob_id", null: false
      t.string "variation_digest", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
    end
    create_table "cart_items" do |t|
      t.bigint "cart_id", null: false
      t.bigint "product_id", null: false
      t.integer "quantity", default: 1
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["cart_id"], name: "index_cart_items_on_cart_id"
      t.index ["product_id"], name: "index_cart_items_on_product_id"
    end
    create_table "carts" do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    create_table "order_items" do |t|
      t.bigint "order_id"
      t.string "product_name"
      t.decimal "price"
      t.integer "quantity"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["order_id"], name: "index_order_items_on_order_id"
    end
    create_table "orders" do |t|
      t.decimal "total_price", precision: 10, scale: 2
      t.string "billing_address"
      t.string "state"
      t.string "zip"
      t.string "last_name"
      t.string "first_name"
      t.string "email"
      t.string "address2"
      t.string "card_name"
      t.string "credit_card_number"
      t.string "card_expiration"
      t.string "card_cvv"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    create_table "products" do |t|
      t.string "name"
      t.text "description"
      t.decimal "price", precision: 10, scale: 2
      t.boolean "published", default: true, null: false
      t.decimal "original_price", precision: 10, scale: 2
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    create_table "sessions" do |t|
      t.string "session_id", null: false
      t.text "data"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
      t.index ["updated_at"], name: "index_sessions_on_updated_at"
    end
    create_table "users" do |t|
      t.string "email", default: "", null: false
      t.string "encrypted_password", default: "", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["email"], name: "index_users_on_email", unique: true
    end
    add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
    add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
    add_foreign_key "cart_items", "carts"
    add_foreign_key "cart_items", "products"
    add_foreign_key "order_items", "orders"
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
  end
end
