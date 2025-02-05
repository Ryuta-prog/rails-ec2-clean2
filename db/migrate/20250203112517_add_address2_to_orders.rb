# frozen_string_literal: true

class AddAddress2ToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :address2, :string
  end
end
