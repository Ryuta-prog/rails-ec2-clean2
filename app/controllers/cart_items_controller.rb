# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :find_product, only: :create
  before_action :find_cart_item, only: :destroy

  def create
    quantity = params[:cart_item][:quantity].to_i.clamp(1, 1000)
    @cart_item = @cart.cart_items.find_or_initialize_by(product: @product)
    @cart_item.quantity = @cart_item.new_record? ? quantity : @cart_item.quantity + quantity

    if @cart_item.save
      redirect_to(request.referer || products_path,
                  notice: t('controllers.cart_items.create.success',
                            product_name: @product.name))
    else
      redirect_to products_path,
                  alert: t('controllers.cart_items.create.failure')
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path,
                alert: t('controllers.cart_items.create.product_not_found')
  end

  def destroy
    if @cart_item.destroy
      redirect_to cart_path,
                  notice: t('controllers.cart_items.destroy.item_removed')
    else
      redirect_to cart_path,
                  alert: t('controllers.cart_items.destroy.item_remove_failed')
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to cart_path,
                alert: t('controllers.cart_items.destroy.item_not_found')
  end

  private

  def find_product
    @product = Product.find(params[:cart_item][:product_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path,
                alert: t('controllers.cart_items.create.product_not_found')
  end

  def find_cart_item
    @cart_item = @cart.cart_items.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to cart_path,
                alert: t('controllers.cart_items.destroy.item_not_found')
  end
end
