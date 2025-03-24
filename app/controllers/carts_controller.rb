# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart

  def show
    @cart = current_cart
    @order = Order.new
    @promotion_code = PromotionCode.find_by(id: session[:promotion_code_id])
    @total = @cart.total_price(@promotion_code)
  end

  def update
    if promotion_params[:promotion_code].present?
      process_promotion_code
    else
      flash[:alert] = t('.no_promotion_code')
    end

    redirect_to cart_path
  end

  private

  def set_cart
    @cart = current_cart
  end

  def promotion_code
    PromotionCode.find_by(id: session[:promotion_code_id])
  end

  def current_cart
    @current_cart ||= Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    create_new_cart
  end

  def promotion_params
    params.permit(:promotion_code)
  end

  def create_new_cart
    cart = Cart.create!
    session[:cart_id] = cart.id
    cart
  end

  def process_promotion_code
    promotion_code = PromotionCode.find_by(
      code: promotion_params[:promotion_code],
      used: false
    )

    if valid_promotion_code?(promotion_code)
      apply_promotion_code(promotion_code)
    else
      clear_promotion_code
    end
  end

  def valid_promotion_code?(promotion_code)
    promotion_code&.valid?
  end

  def apply_promotion_code(promotion_code)
    session[:promotion_code_id] = promotion_code.id
    flash_type = redirect_to_option ? flash : flash.now
    flash_type[:notice] = t('.promotion_applied', discount: number_to_currency(promotion_code.discount_amount))
  end

  def clear_promotion_code
    session.delete(:promotion_code_id)
    flash.now[:alert] = t('.invalid_promotion')
  end
end
