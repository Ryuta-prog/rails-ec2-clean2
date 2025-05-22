# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart

  # カート画面の表示
  def show
    @order = Order.new
    @promotion_code = PromotionCode.find_by(id: session[:applied_promotion_code_id])
    @total_price = @cart.total_price(@promotion_code)
  end

  # カートの数量更新
  def update
    @cart.update_items(params[:cart_items])
    if @cart.update(cart_params)
      redirect_to cart_path, notice: t('.updated', default: 'カートを更新しました')
    else
      flash.now[:alert] = t('.update_failed', default: 'カートの更新に失敗しました')
      render :show, status: :unprocessable_entity
    end
  end

  # プロモーションコードの適用
  def apply_promotion_code
    code = params[:promotion_code].to_s.upcase.strip
    promo = PromotionCode.find_by(code: code, used: false)

    if promo
      session[:applied_promotion_code_id] = promo.id
      redirect_to cart_path, notice: t('.success')
    else
      session.delete(:applied_promotion_code_id)
      flash.now[:alert] = t('.not_found')
      render :show, status: :unprocessable_entity
    end
  end

  # プロモーションコードの解除
  def remove_promotion_code
    session.delete(:applied_promotion_code_id)
    redirect_to cart_path, notice: t('.removed')
  end

  private

  def cart_params
    params.fetch(:cart, {}).permit(cart_items_attributes: %i[id quantity _destroy])
  end
end
