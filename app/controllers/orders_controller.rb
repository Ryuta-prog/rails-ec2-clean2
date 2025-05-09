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

  # カートからの注文確定
  def create
    @order = current_user.orders.new(order_params)
    load_promotion
    set_total_price

    if @order.save
      create_order_items
      finalize_order
      redirect_to @order, notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render 'carts/show', status: :unprocessable_entity
    end
  end

  private

  # before_action で呼び出す：セッション or 新規作成からカートを取得
  def set_cart
    @cart = current_cart
  end

  # セッションから適用中のプロモーションコードを読み込み、Order に紐付け
  def load_promotion
    @promo = PromotionCode.find_by(id: session[:applied_promotion_code_id])
    @order.promotion_code = @promo if @promo&.usable?
  end

  # サーバ側で必ず割引後の合計を再計算
  def set_total_price
    @order.total_price = @cart.total_price(@promo)
  end

  # 注文明細(OrderItem)の作成
  def create_order_items
    @cart.cart_items.each do |ci|
      @order.order_items.create!(
        product_id: ci.product_id,
        product_name: ci.product.name,
        price: ci.product.price,
        quantity: ci.quantity
      )
    end
  end

  # カートのクリア、セッション削除、確認メール送信
  def finalize_order
    @cart.destroy!
    session.delete(:cart_id)
    session.delete(:applied_promotion_code_id)
    OrderMailer.with(order: @order).confirmation_email.deliver_later
  end

  # strong parameters で受け取るパラメータを制限
  def order_params
    params.require(:order).permit(
      :last_name, :first_name, :email,
      :billing_address, :address2, :state, :zip,
      :card_name, :credit_card_number,
      :card_expiration, :card_cvv
    )
  end
end
