class OrdersController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "pw", only:[:index, :show]
  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total = current_cart.total_price

    if @order.save
      # カートの中身を注文詳細として保存
      current_cart.line_items.each do |item|
        @order.order_items.create(product: item.product, quantity: item.quantity, price: item.product.price)
      end
      
      # メールを送信する
      OrderMailer.order_confirmation(@order).deliver_now

      # カートを空にする
      session[:card_id] = nil

      flash[:notice] = "購入ありがとうございます"
      redirect_to root_path
    else
      render 'carts/show'
    end
  end

  private

  def order_params
    params.require(:order).permit(:billing_address, :credit_card_number)
  end
end
