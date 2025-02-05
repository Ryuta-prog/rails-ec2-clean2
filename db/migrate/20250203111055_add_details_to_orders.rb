# frozen_string_literal: true

class AddDetailsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :last_name, :string
    add_column :orders, :first_name, :string
    add_column :orders, :email, :string
  end
end
