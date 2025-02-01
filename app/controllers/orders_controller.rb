def create
  @order = Order.new(order_params)
  @order.user = current_user
  @order.total = current_cart.total_price

  if @order.save
    # カート内の商品を購入明細として保存
    current_cart.cart_items.each do |item|
      OrderItem.create!(
        order: @order,
        product_name: item.product.name,
        price: item.product.price,
        quantity: item.quantity
      )
    end

    # メール送信とエラー処理
      OrderMailer.order_confirmation(@order).deliver_now
    rescue => e
      Rails.logger.error "Failed to send email: #{e.message}"
    end

    # カートを削除
    current_cart.destroy
    session[:cart_id] = nil

    flash[:notice] = "購入ありがとうございます"
    redirect_to root_path
  else
    flash[:alert] = "購入処理に失敗しました"
    render 'carts/show'
  end
end
