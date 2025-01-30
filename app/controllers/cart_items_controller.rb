# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :set_cart
  before_action :find_cart_item, only: [:destroy]

  def create
    product = Product.find(params[:product_id])
    quantity = params[:quantity].present? ? params[:quantity].to_i : 1
    @cart_item = @cart.add_product!(product, quantity)
    redirect_to request.referer, notice: t('.success')
  rescue ActiveRecord::RecordInvalid
    redirect_to request.referer, alert: t('.failure')
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_path, notice: t('.item_removed')
  end

  private

  def find_cart_item
    @cart_item = @cart.cart_items.find(params[:id])
  end
end
