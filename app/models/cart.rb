# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  
  def add_product!(product, quantity = 1)
  current_item = cart_items.find_by(product_id: product.id)

  if current_item
    current_item.quantity += quantity
    current_item.save!
  else
    current_item = cart_items.create!(product_id: product.id, quantity: quantity)
  end
  
  current_item
  end
  
  def total_price
  cart_items.sum { |item| item.product.price * item.quantity }
  end
end
