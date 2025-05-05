# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def show
    @order = Order.new
    @promotion_code = current_promotion_code
    @total_price = @cart.total_price(@promotion_code)
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

  def current_cart
    @current_cart ||= Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    create_new_cart
  end

  def create_new_cart
    cart = Cart.create!
    session[:cart_id] = cart.id
    cart
  end

  def current_promotion_code
    PromotionCode.find_by(id: session[:applied_promotion_code_id])
  end

  def promotion_params
    params.permit(:promotion_code)
  end

  def process_promotion_code
    code = promotion_params[:promotion_code].upcase.strip
    promotion_code = PromotionCode.find_by(code: code)

    if promotion_code&.usable?
      apply_promotion_code(promotion_code)
    else
      clear_promotion_code
    end
  end

  def apply_promotion_code(promotion_code)
    session[:applied_promotion_code_id] = promotion_code.id
    flash[:notice] = t('.promotion_applied', discount: number_to_currency(promotion_code.discount_amount))
  end

  def clear_promotion_code
    session.delete(:applied_promotion_code_id)
    flash[:alert] = t('.invalid_promotion')
  end
end
