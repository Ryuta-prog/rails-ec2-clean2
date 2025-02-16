class AddBillingAddressToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :billing_address, :string
  end
end
