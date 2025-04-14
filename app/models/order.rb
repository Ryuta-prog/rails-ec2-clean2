# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :promotion_code, optional: true
  has_many :order_items, dependent: :destroy

  validates :last_name, :first_name, :email, :billing_address, :state, :zip, :card_name,
            :credit_card_number, :card_expiration, :card_cvv, :total_price, presence: true

  # プロモコード適用処理を追加
  def apply_promotion_code(code)
    promotion_code = PromotionCode.find_by(code: code, used: false)
    return false unless promotion_code

    ActiveRecord::Base.transaction do
      update!(promotion_code: promotion_code)
      promotion_code.update!(used: true)
    end

    true
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Failed to apply promotion code: #{e.message}")
    false
  end
end
