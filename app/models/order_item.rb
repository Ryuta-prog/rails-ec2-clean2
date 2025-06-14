# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :product_name, :price, :quantity, presence: true
end
