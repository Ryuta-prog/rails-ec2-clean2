# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  # 商品追加メソッド
  def add_product(product, quantity = 1)
    cart_items.find_or_initialize_by(product: product).tap do |item|
      item.quantity += quantity
      item.save
    end
  end

  # 合計金額（割引前）
  def subtotal
    cart_items.includes(:product).sum { |item| item.product.price * item.quantity }
  end

  # 割引適用後の合計金額
  def total_price(promotion_code = nil)
    total = subtotal

    if promotion_code.present? && !promotion_code.used
      discount = promotion_code.discount_amount.to_f
      total -= discount
    end

    total
  end
end
