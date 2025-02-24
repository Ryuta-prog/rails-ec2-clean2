class AddDetailsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :last_name, :string
    add_column :orders, :first_name, :string
    add_column :orders, :email, :string
    add_column :orders, :billing_address, :string
    add_column :orders, :address2, :string
    add_column :orders, :state, :string
    add_column :orders, :zip, :string
    add_column :orders, :card_name, :string
  end
end
