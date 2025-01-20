# frozen_string_literal: true

class AddOriginalPriceToProducts < ActiveRecord::Migration[7.0]
  def change
    return if column_exists?(:products, :original_price)

    add_column :products, :original_price, :decimal
  end
end
