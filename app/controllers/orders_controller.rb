# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!
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
      mark_promo_used
      create_order_items
      generate_next_coupon
      clear_cart_and_session
      OrderMailer.with(order: @order).confirmation_email.deliver_later
      redirect_to products_path, notice: t('.success', coupon: @next_coupon.code)
    else
      flash.now[:alert] = t('.failure')
      render 'carts/show', status: :unprocessable_entity
    end
  end

  private

  def set_cart
    @cart = current_cart
  end

  # strong_params で受け取るのはお客様情報のみ
  def order_params
    params.require(:order).permit(
      :last_name, :first_name, :email,
      :billing_address, :address2, :state, :zip,
      :card_name, :credit_card_number,
      :card_expiration, :card_cvv
    )
  end

  # -----------------------
  # 以下、 create アクションのサブ処理
  # -----------------------

  def build_order_from_cart
    @order = current_user.orders.new(order_params)
    promo = PromotionCode.find_by(id: session[:applied_promotion_code_id])
    @order.total_price = @cart.total_price(promo)
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

  def generate_next_coupon
    @next_coupon = current_user.promotion_codes.create!(
      code: SecureRandom.alphanumeric(7).upcase,
      discount_amount: rand(100..1000),
      used: false
    )
  end

  def clear_cart_and_session
    @cart.destroy!
    session.delete(:cart_id)
    session.delete(:applied_promotion_code_id)
  end
end
