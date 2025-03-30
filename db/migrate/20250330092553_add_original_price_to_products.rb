class AddOriginalPriceToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :original_price, :decimal
  end
end
