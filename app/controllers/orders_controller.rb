# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = build_order
    @order.user_id = nil
    if @order.save
      process_successful_order
    else
      handle_failed_order
    end
  end
  
  private
  
  def build_order
    Order.new(order_params).tap do |order|
      order.total = current_cart.total_price
    end
  end
  
  def process_successful_order
    create_order_items
    send_confirmation_email
    clear_cart
    redirect_to root_path, notice: '購入ありがとうございます'
  end
  
  def create_order_items
    current_cart.cart_items.each do |cart_item|
      @order.order_items.create!(
        product_name: cart_item.product.name,
        price: cart_item.product.price,
        quantity: cart_item.quantity
      )
    end
  end

  def send_confirmation_email
    OrderMailer.confirmation_email(@order).deliver_later
  end

  def clear_cart
    current_cart.destroy
    session[:cart_id] = nil
  end

  def handle_failed_order
    Rails.logger.error("Order creation failed: #{@order.errors.full_messages.join(', ')}")
    flash.now[:alert] = '入力内容に誤りがあります。再度確認してください。'
    render 'carts/show', status: :unprocessable_entity
  end

  def order_params
    params.require(:order).permit(
      :last_name, :first_name, :email, :billing_address, :address2,
      :state, :zip, :card_name, :credit_card_number, :card_expiration,
      :card_cvv, :total
    )
  end
end
