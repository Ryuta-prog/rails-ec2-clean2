# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  # 合計金額（割引前）
  def original_price
    cart_items.includes(:product).sum do |item|
      item.product.original_price.to_i * item.quantity
    end
  end

  # 割引後の合計金額
  def discounted_price(promotion_code = nil)
    total = original_price
    return total if promotion_code_id.nil? || promotion_code.used?

    total - promotion_code.discount_amount.to_f
  end
end
