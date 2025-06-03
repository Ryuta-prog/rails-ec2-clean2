# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_cart, only: :create

  # チェックアウト実行
  def create
    # モデル側のクラスメソッドで一括注文作成＋後処理を実行
    @order = Order.create_with_cart!(
      cart: @cart,
      promo_id: session[:applied_promotion_code_id],
      order_params: order_params
    )

    # 注文成功時は商品一覧へリダイレクトし、クーポンコードをフラッシュに表示
    redirect_to products_path, notice: t('.success_with_coupon', coupon: @order.next_coupon_code)

    # セッションからカートIDとプロモーションコードIDを削除
    session.delete(:cart_id)
    session.delete(:applied_promotion_code_id)
  rescue ActiveRecord::RecordInvalid
    # バリデーションエラーの場合はカート画面を再表示（422）
    flash.now[:alert] = t('.failure')
    render 'carts/show', status: :unprocessable_entity
  rescue StandardError => e
    # 想定外エラー時はログ出力し、カート画面を再表示（500）
    Rails.logger.error(I18n.t('orders.create.error_log', message: e.message))
    flash.now[:alert] = t('.critical_failure')
    render 'carts/show', status: :internal_server_error
  end

  private

  # カート情報をセット（before_action で実行）
  def set_cart
    @cart = current_cart
  end

  # フォームから送信された注文情報を許可する
  def order_params
    params.require(:order).permit(
      :last_name, :first_name, :email,
      :billing_address, :address2, :state, :zip,
      :card_name, :credit_card_number,
      :card_expiration, :card_cvv
    )
  end
end
