class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    change_table :orders do |t|
      t.integer :total unless column_exists?(:orders, :total)
      t.string :billing_address unless column_exists?(:orders, :billing_address)
      t.string :credit_card_number unless column_exists?(:orders, :credit_card_number)
    end
  end
end
