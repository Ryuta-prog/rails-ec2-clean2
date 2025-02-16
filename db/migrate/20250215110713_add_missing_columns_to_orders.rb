class AddMissingColumnsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :user, foreign_key: true
    # credit_card_numberの行を削除または条件付きで追加
    add_column :orders, :credit_card_number, :string unless column_exists?(:orders, :credit_card_number)
  end
end
