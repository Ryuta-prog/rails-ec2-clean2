# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_order, only: [:create]

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    apply_promotion_code if params[:promotion_code].present?

    if @order.save
      process_successful_order
    else
      handle_failed_order
    end
  end

  private

  def initialize_order
    @order = current_user.orders.build(order_params)
    promotion_code = PromotionCode.find_by(id: session[:promotion_code_id])
    @order.total_price = current_cart.total_price(promotion_code)
  end

  def apply_promotion_code
    service = PromotionService.new(@order, params[:promotion_code])
    result = service.apply

    return unless result[:success]

    flash.now[:notice] = t('.promotion_applied', discount: number_to_currency(result[:discount]))
  end

  def process_successful_order
    create_order_items
    send_confirmation_email
    clear_cart
    redirect_to root_path, notice: t('.purchase_success')
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
    log_order_error
    render 'carts/show', status: :unprocessable_entity
  end

  def log_order_error
    Rails.logger.error("Order creation failed: #{@order.errors.full_messages.join(', ')}")
    flash.now[:alert] = t('input_error')
  end

  def order_params
    params.require(:order).permit(
      :last_name, :first_name, :email, :billing_address, :address2,
      :state, :zip, :card_name, :credit_card_number, :card_expiration,
      :card_cvv
    )
  end
end
