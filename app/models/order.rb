# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :user
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :email, presence: true
  validates :billing_address, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :card_name, presence: true
  validates :credit_card_number, presence: true
  validates :card_expiration, presence: true
  validates :card_cvv, presence: true
  validates :total, presence: true
end
