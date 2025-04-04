# frozen_string_literal: true

class AddCardDetailsToOrders < ActiveRecord::Migration[7.0]
  def change
    change_table :orders, bulk: true do |t|
      t.string :card_name
      t.string :credit_card_number
      t.string :card_expiration
      t.string :card_cvv
    end
  end
end
