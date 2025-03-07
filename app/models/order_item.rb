# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  validates :product_name, :price, :quantity, presence: true
end
