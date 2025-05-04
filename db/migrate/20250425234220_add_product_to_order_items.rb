# frozen_string_literal: true

class AddProductToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :order_items, :product, foreign_key: true
  end
end
