# frozen_string_literal: true

class PromotionCodesController < ApplicationController
  def apply
    code = params[:promotion_code].to_s.upcase.strip
    promotion_code = PromotionCode.find_by(code: code, used: false)

    if promotion_code
      session[:applied_promotion_code_id] = promotion_code.id
      redirect_to cart_path, notice: t('.success')
    else
      session.delete(:applied_promotion_code_id)
      flash.now[:alert] = t('.invalid')
      render 'carts/show', status: :unprocessable_entity
    end
  end

  def remove
    session.delete(:applied_promotion_code_id)
    redirect_to cart_path, notice: t('.success')
  end
end
