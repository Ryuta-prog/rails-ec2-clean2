# frozen_string_literal: true

class OrdersController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "pw", only: [:index, :show]

  def index
    @orders = Order.all.order(created_at: :desc)
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total = current_cart.total_price

    if @order.save
      # カートの中身を注文詳細として保存
      current_cart.cart_items.each do |item|
        OrderItem.create!(
          order: @order,
          product: item.product.name,
          price: item.product.price,
          quantity: item.quantity
        )
      end

      # メールを送信する
      OrderMailer.order_confirmation(@order).deliver_later

      # カートを削除する
      current_cart.destroy
      session[:card_id] = nil

      flash[:notice] = "購入ありがとうございます"
      redirect_to root_path
    else
      render 'carts/show'
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :billing_address, :state, :zip,
      card_name, :credit_card_number,
      :card_expiration, :card_cvv
    )
  end
end
