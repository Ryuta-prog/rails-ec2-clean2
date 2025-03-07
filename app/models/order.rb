# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  validates :last_name, :first_name, :email, :billing_address, :state, :zip, :card_name,
            :credit_card_number, :card_expiration, :card_cvv, :total_price, presence: true
end
