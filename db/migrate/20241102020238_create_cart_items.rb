# frozen_string_literal: true

class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.integer :cart_id, null: false
      t.integer :product_id, null: false
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end

    add_index :cart_items, :cart_id
    add_index :cart_items, :product_id
  end
end
