# frozen_string_literal: true

class PromotionCodesController < ApplicationController
  before_action :authenticate_user!

  # プロモーションコード適用処理
  def apply
    code = current_user.promotino_codes.unused.find.unused.find_by(code: params[:promotion_code])

    if code
      session[:promotion_code_id] = code.id
      redirect_to cart_path, notice: t('.apply.success')
    else
      redirect_to cart_path, alert: t('.apply.invalid')
    end
  end

  # プロモーションコード解除処理
  def destroy
    if session[:promotion_code_id]
      session.delete(:promotion_code_id)
      redirect_to cart_path, notice: t('.destroy.success')
    else
      redirect_to cart_path, alert: t('.destroy.not_found')
    end
  end
end
