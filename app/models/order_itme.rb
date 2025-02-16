# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  validates :product_name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
end
