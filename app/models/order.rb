# frozen_string_literal: true

class Order < ApplicationRecord
  # ---------------------------------
  # ◼︎ 1. アソシエーション・バリデーション
  # ---------------------------------
  belongs_to :promotion_code, optional: true
  has_many :order_items, dependent: :destroy

  validates :last_name, :first_name, :billing_address, :state, :zip, :card_name,
            :credit_card_number, :card_expiration, :card_cvv, :discounted_price, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :card_expiration, format: {
    with: %r{\A(0[1-9]|1[0-2])/\d{2}\z},
    message: :invalid_card_expiration_format
  }

  # ---------------------------------
  # ◼︎ 2. 公開メソッド(コントローラ等から呼び出し)
  # ---------------------------------

  # ユーザーが手動でクーポンを適用するときに呼ぶ
  def apply_promotion_code(code)
    promo = PromotionCode.find_by(code: code, used: false)
    return false unless promo

    ActiveRecord::Base.transaction do
      update!(promotion_code: promo)
      promo.update!(used: true)
    end

    true
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Failed to apply promotion code: #{e.message}")
    false
  end

  # カート情報を使い、トランザクション内で注文作成→後処理を行う
  def self.create_with_cart!(cart:, promo_id:, order_params:)
    transaction do
      promo = PromotionCode.find_by(id: promo_id)
      order = new(order_params)
      order.discounted_price = cart.discounted_price(promo)
      order.promotion_code   = promo if promo&.usable?
      order.save!
      order.process_after_save!(cart)
      order
    end
  end

  # ---------------------------------
  # ◼︎ 3. 内部用メソッド(private 以下にまとめる)
  # ---------------------------------
  private

  # 注文保存後に呼ばれる一連の処理
  def process_after_save!(cart)
    # 割引価格を再計算して確定
    self.discounted_price = cart.discounted_price(promotion_code)
    save!

    # プロモーションコードを使用済みに更新
    promotion_code&.update!(used: true)

    # 注文明細を作成
    cart.cart_items.find_each do |ci|
      order_items.create!(
        product_id: ci.product_id,
        product_name: ci.product.name,
        price: ci.product.price,
        quantity: ci.quantity
      )
    end

    # 次回クーポンを発行してインスタンス変数に保持
    @next_coupon = PromotionCode.create!(
      code: SecureRandom.alphanumeric(7).upcase,
      discount_amount: rand(100..1000),
      used: false
    )

    # カートをクリア
    cart.destroy!

    # 確認メールを非同期で送信
    OrderMailer.with(order: self).confirmation_email.deliver_later
  end

  # コントローラ側で表示するクーポンコードを返す
  def next_coupon_code
    @next_coupon&.code
  end
end
