# frozen_string_literal: true

class CreateCoreTables < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'plpgsql' unless extension_enabled?('plpgsql')

    # ────────────────────────────────────────────────────
    # Users テーブル（system_account を含む）
    create_table :users, if_not_exists: true do |t|
      t.string   :email,              null: false
      t.string   :encrypted_password, null: false
      t.string   :last_name,          null: false
      t.string   :first_name,         null: false
      t.boolean  :system_account,     default: false, null: false
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.timestamps
      t.index :email, unique: true
      t.index :reset_password_token, unique: true
    end

    # Products テーブル
    create_table :products, if_not_exists: true do |t|
      t.string   :name, null: false
      t.text     :description
      t.decimal  :price,          precision: 10, scale: 2, null: false
      t.decimal  :original_price, precision: 10, scale: 2
      t.boolean  :published,      default: true, null: false
      t.timestamps
    end

    # Carts テーブル
    create_table :carts, if_not_exists: true do |t|
      t.references :user, foreign_key: true, null: true
      t.timestamps
    end

    # CartItems テーブル
    create_table :cart_items, if_not_exists: true do |t|
      t.references :cart,    null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer    :quantity, default: 1, null: false
      t.timestamps
    end

    # PromotionCodes テーブル（user_id を NULL 許可）
    create_table :promotion_codes, if_not_exists: true do |t|
      t.string   :code,            null: false, limit: 7
      t.integer  :discount_amount, null: false
      t.boolean  :used,            default: false, null: false
      t.references :user, foreign_key: true, null: true
      t.timestamps
      t.index :code, unique: true
      t.index :used
    end

    # Orders テーブル（user_id, promotion_code_id を NULL 許可）
    create_table :orders, if_not_exists: true do |t|
      t.references :user,           foreign_key: true, null: true
      t.references :promotion_code, foreign_key: true, null: true
      t.decimal    :total_price,    precision: 10, scale: 2, null: false
      t.string     :billing_address
      t.string     :address2
      t.string     :state
      t.string     :zip
      t.string     :last_name
      t.string     :first_name
      t.string     :email
      t.string     :card_name
      t.string     :credit_card_number
      t.string     :card_expiration
      t.string     :card_cvv
      t.timestamps
    end

    # OrderItems テーブル（product 参照をまとめて）
    create_table :order_items, if_not_exists: true do |t|
      t.references :order,   null: false, foreign_key: true
      t.references :product, foreign_key: true, null: true
      t.string     :product_name
      t.decimal    :price, precision: 10, scale: 2
      t.integer    :quantity, null: false
      t.timestamps
    end

    # Sessions テーブル（ActiveRecord::SessionStore 用）
    create_table :sessions, if_not_exists: true do |t|
      t.string :session_id, null: false
      t.text   :data
      t.timestamps
      t.index :session_id, unique: true
    end
  end
end
