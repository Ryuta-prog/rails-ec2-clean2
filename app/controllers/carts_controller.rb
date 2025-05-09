# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!
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
      redirect_to cart_path, notice: t('.updated', default: 'カートを
    を更新しました')
    else
      flash.now[:alert] = t('.update_failed', default: 'カートの更新に失敗しました')
      render :show, status: :unprocessable_entity
    end
  end

  # プロモーションコードの適用(PATCH /cart/apply_promotion_code)
  def apply_promotion_code
    code = params[:promotion_code].to_s.upcase.strip
    promotion = PromotionCode.find_by(code: code, used: false)

    if promotion
      session[:applied_promotion_code_id] = promotion.id
      redirect_to cart_path, notice: t('.success', default: 'プロモーションコードを適用しました')
    else
      session.delete(:applied_promotion_code_id)
      flash.now[:alert] = t('.invalid', default:
      '無効なプロモーションコードです')
      render :show, status: :unprocessable_entity
    end
  end

  # プロモーションコードの解除U(DELETE /cart/remove_promotion_code)
  def remove_promotion_code
    session.delete(:applied_promotion_code_id)
    redirect_to cart_path, notice: t('.removed', default: 'プロモーションコードを解除しました')
  end

  private

  def set_cart
    @cart = current_cart
  end

  # session からカートを取り出す/なければ作成
  def current_cart
    Cart.find(session[:cart_id]).tap { |c| session[:cart_id] = c.id }
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create!
    session[:cart_id] = cart.id
    cart
  end

  # カート更新用の strong params(例示)
  def cart_params
    params.require(:cart).permit(cart_items_attributes: %i[id quantity_destroy])
  end
end
