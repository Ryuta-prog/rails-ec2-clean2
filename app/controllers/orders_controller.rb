# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :basic_auth, only: %i[index show]

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    @order.total = current_cart.total_price

    if @order.save
      # 注文明細の保存
      current_cart.cart_items.each do |cart_item|
        @order.order_items.create!(
          product_name: cart_item.product.name,
          price: cart_item.product.price,
          quantity: cart_item.quantity
        )
      end

      # メールの送信
      OrderMailer.confirmation_email(@order).deliver_later

      # カートの削除
      current_cart.destroy
      session[:cart_id] = nil

      redirect_to root_path, notice: '購入ありがとうございます'
    else
      render 'carts/show', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :last_name,
      :first_name,
      :email,
      :billing_address,
      :address2,
      :state,
      :zip,
      :card_name,
      :credit_card_number,
      :card_expiration,
      :card_cvv,
      :total
    )
  end
end
