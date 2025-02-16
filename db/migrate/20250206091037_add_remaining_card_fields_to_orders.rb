# frozen_string_literal: true

class AddRemainingCardFieldsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :card_name, :string
    add_column :orders, :card_expiration, :string
    add_column :orders, :card_cvv, :string
  end
end
