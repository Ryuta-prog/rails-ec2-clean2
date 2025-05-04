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

  # 合計金額計算（基本）
  def subtotal
    cart_items.includes(:product).sum { |item| item.product.price * item.quantity }
  end

  # 割引適用後の合計金額
  def total_price(discount_amount = 0)
    subtotal = cart_items.sum do |item|
      item.product.price.to_d * item.quantity
    end
    subtotal - discount_amount.to_d
  end
end
