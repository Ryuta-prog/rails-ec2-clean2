# frozen_string_literal: true

class AddCreditCardNumberToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :credit_card_number, :string
  end
end
