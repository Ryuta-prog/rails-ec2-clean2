# frozen_string_literal: true

class CreateCoreTables < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'plpgsql' unless extension_enabled?('plpgsql')

    create_users_table
    create_products_table
    create_carts_table
    create_cart_items_table
    create_promotion_codes_table
    create_orders_table
    create_order_items_table
    create_sessions_table
  end

  private

  def create_users_table
    return if table_exists?(:users)

    create_table :users do |t|
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.timestamps
      t.index :email, unique: true
    end
  end

  def create_products_table
    return if table_exists?(:products)

    create_table :products do |t|
      t.string  :name, null: false
      t.text    :description
      t.decimal :price,          precision: 10, scale: 2
      t.decimal :original_price, precision: 10, scale: 2 # original_priceを追加
      t.boolean :published,      default: true, null: false
      t.timestamps
    end
  end

  def create_carts_table
    return if table_exists?(:carts)

    create_table :carts do |t|
      t.references :user, foreign_key: true
      t.timestamps
    end
  end

  def create_cart_items_table
    return if table_exists?(:cart_items)

    create_table :cart_items do |t|
      t.references :cart,    null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer    :quantity, default: 1
      t.timestamps
    end
  end

  def create_promotion_codes_table
    return if table_exists?(:promotion_codes)

    create_table :promotion_codes do |t|
      t.string   :code, null: false, limit: 7
      t.integer  :discount_amount, null: false
      t.boolean  :used, default: false, null: false
      t.datetime :valid_from
      t.datetime :valid_until
      t.timestamps
      t.index :code, unique: true
      t.index :used
    end
  end

  def create_orders_table
    return if table_exists?(:orders)

    create_table :orders do |t|
      t.references :user,             null: false, foreign_key: true
      t.references :promotion_code,   foreign_key: true
      t.decimal    :total_price,      precision: 10, scale: 2
      t.string     :billing_address
      t.string     :state
      t.string     :zip
      t.string     :last_name
      t.string     :first_name
      t.string     :email
      t.string     :address2
      t.string     :card_name
      t.string     :credit_card_number
      t.string     :card_expiration
      t.string     :card_cvv
      t.timestamps
    end
  end

  def create_order_items_table
    return if table_exists?(:order_items)

    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.string     :product_name
      t.decimal    :price, precision: 10, scale: 2
      t.integer    :quantity
      t.timestamps
    end
  end

  def create_sessions_table
    return if table_exists?(:sessions)

    create_table :sessions do |t|
      t.string   :session_id, null: false
      t.text     :data
      t.timestamps
      t.index :session_id, unique: true
    end
  end
end
