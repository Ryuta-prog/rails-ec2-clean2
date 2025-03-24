# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :set_cart
  before_action :find_cart_item, only: [:destroy]

  def index
    @cart_items = current_cart.cart_items.includes(:product)
  end

  def create
    product = Product.find(params[:cart_item][:product_id])
    quantity = params[:cart_item][:quantity].to_i
    @cart_item = @cart.cart_items.find_or_initialize_by(product_id: product.id)
    @cart_item.quantity = calculate_quantity(@cart_item, quantity)

    if @cart_item.save
      handle_success_response(product)
    else
      handle_failure_response
    end
  end

  def destroy
    if @cart_item.destroy
      redirect_to cart_path, notice: t('.item_removed')
    else
      redirect_to cart_path, alert: t('.item_remove_failed')
    end
  end

  private

  def calculate_quantity(cart_item, quantity)
    cart_item.new_record? ? quantity : cart_item.quantity + quantity
  end

  def handle_success_response(product)
    notice_message = t('.success', product_name: product.name)
    respond_to do |format|
      format.html { redirect_to(request.referer || products_path, notice: notice_message) }
      format.js # 非同期リクエスト用のレスポンス（create.js.erb を呼び出す）
    end
  end

  def handle_failure_response
    respond_to do |format|
      format.html { redirect_to(products_path, alert: t('.failure')) }
      format.js # エラーメッセージ表示用
    end
  end

  def find_product
    Product.find(params[:cart_item][:product_id])
  end

  def extract_quantity
    params[:cart_item][:quantity]
  end

  def build_cart_item(product, quantity)
    @cart.cart_items.find_or_initialize_by(product: product).tap do |item|
      item.quantity += quantity.to_i.clamp(1, 1000)
    end
  end

  def set_cart
    @cart = current_cart
  end

  def find_cart_item
    @cart_item = @cart.cart_items.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to cart_path, alert: t('.item_not_found')
  end

  def log_and_redirect_error(error)
    Rails.logger.error "商品検索エラー: #{error.message}"
    redirect_to products_path, alert: t('.product_not_found')
  end
end
