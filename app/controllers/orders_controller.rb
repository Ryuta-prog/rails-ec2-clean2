# frozen_string_literal: true

class OrdersController < ApplicationController
  def create
    @order = build_order

    if @order.save
      process_successful_order
    else
      handle_failed_order
    end
  rescue => e
    handle_error(e)
  end

  private

  def build_order
    Order.new(order_params).tap do |order|
      order.user = current_user
      order.total = current_cart.total_price
    end
  end

  def process_successful_order
    create_order_items
    send_order_confirmation
    clear_cart
    set_success_message
  end

  def create_order_items
    current_cart.cart_items.each do |item|
      OrderItem.create!(
        order: @order,
        product_name: item.product.name,
        price: item.product.price,
        quantity: item.quantity
      )
    end
  end

  def clear_cart
    current_cart.destroy
    session[:cart_id] = nil
  end

  def set_success_message
    flash[:notice] = "購入ありがとうございます"
    redirect_to root_path
  end

  def handle_failed_order
    flash[:alert] = "購入処理に失敗しました"
    render 'carts/show'
  end

  def send_order_confirmation
    OrderMailer.order_confirmation(@order).deliver_now
  end
end
