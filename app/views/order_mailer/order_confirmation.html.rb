<h1>購入明細</h1>
<p>注文番号: <%= @order.id %></p>
<p>合計金額: <%= number_to_currency(@order.total) %></p>
# <!-- 注文アイテムの詳細をここに追加 -->