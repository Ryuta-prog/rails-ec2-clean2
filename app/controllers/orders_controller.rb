# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_cart, only: :create

  # チェックアウト実行
  def create
    @order = Order.create_with_cart!(
      cart: @cart,
      promo_id: session[:applied_promotion_code_id],
      order_params: order_params
    )

    redirect_to products_path,
                notice: t('controllers.orders.create.success_with_coupon',
                          coupon: @order.next_coupon_code)

    session.delete(:cart_id)
    session.delete(:applied_promotion_code_id)
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = t('controllers.orders.create.failure')
    render 'carts/show', status: :unprocessable_entity
  rescue StandardError => e
    Rails.logger.error(I18n.t('controllers.orders.create.error_log',
                              message: e.message))
    flash.now[:alert] = t('controllers.orders.create.critical_failure')
    render 'carts/show', status: :internal_server_error
  end

  private

  def set_cart
    @cart = current_cart
  end

  def order_params
    params.require(:order).permit(
      :last_name, :first_name, :email,
      :billing_address, :address2, :state, :zip,
      :card_name, :credit_card_number,
      :card_expiration, :card_cvv
    )
  end
end
