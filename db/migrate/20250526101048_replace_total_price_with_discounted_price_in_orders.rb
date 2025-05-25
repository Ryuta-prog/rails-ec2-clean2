# frozen_string_literal: true

class ReplaceTotalPriceWithDiscountedPriceInOrders < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        change_table :orders, bulk: true do |t|
          t.remove :total_price
          t.decimal :discounted_price, precision: 10, scale: 2, null: false, default: 0
        end
      end

      dir.down do
        change_table :orders, bulk: true do |t|
          t.decimal :total_price, precision: 10, scale: 2
          t.remove :discounted_price
        end
      end
    end
  end
end
