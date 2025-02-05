# frozen_string_literal: true

class AddRemainingFieldsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :zip, :string
  end
end
