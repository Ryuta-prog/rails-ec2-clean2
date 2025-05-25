# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_cart, only: :create

  # 過去の注文一覧表示
  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  # 注文詳細表示
  def show
    @order = current_user.orders.find(params[:id])
  end

  # チェックアウト実行
  def create
    build_order_from_cart

    if @order.save
      process_success_flow
      redirect_to products_path, notice: @notice_msg
    else
      flash.now[:alert] = t('.failure')
      render 'carts/show', status: :unprocessable_entity
    end
  end

  private

  # 以下、create内の処理をまとめて切り出し
  def process_success_flow
    mark_promo_used
    create_order_items
    generate_coupon_and_notice
    clear_cart_and_session
    OrderMailer.with(order: @order).confirmation_email.deliver_now
  end

  def generate_coupon_and_notice
    @next_coupon = PromotionCode.create!(
      user: current_user,
      code: SecureRandom.alphanumeric(7).upcase,
      discount_amount: rand(100..1000),
      used: false
    )
    @notice_msg = t('.success_with_coupon', coupon: @next_coupon.code)
  end

  def set_cart
    @cart = current_cart
  end

  def order_params
    params.require(:order).permit(
      :last_name, :first_name, :email,
      :billing_address, :address2, :state, :zip,
      :card_name, :credit_card_number,
      :card_expiration, :card_cvv
    )
  end

  def build_order_from_cart
    @order = Order.new(order_params)
    @order.user = current_user if current_user

    promo = PromotionCode.find_by(id: session[:applied_promotion_code_id])
    @order.discounted_price = @cart.discounted_price(promo)
    @order.promotion_code = promo if promo&.usable?
  end

  def mark_promo_used
    @order.promotion_code&.update!(used: true)
  end

  def create_order_items
    @cart.cart_items.find_each do |ci|
      @order.order_items.create!(
        product_id: ci.product_id,
        product_name: ci.product.name,
        price: ci.product.price,
        quantity: ci.quantity
      )
    end
  end

  def clear_cart_and_session
    @cart.destroy!
    session.delete(:cart_id)
    session.delete(:applied_promotion_code_id)
  end
end
