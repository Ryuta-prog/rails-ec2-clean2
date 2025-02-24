# frozen_string_literal: true

class AddDetailsToOrders < ActiveRecord::Migration[7.0]
  def change
    change_table :orders, bulk: true do |t|
      t.string :last_name
      t.string :first_name
      t.string :email
      t.string :address2
      t.string :state
      t.string :zip
      t.string :card_name
    end
  end
end
