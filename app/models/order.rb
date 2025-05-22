# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :promotion_code, optional: true
  has_many :order_items, dependent: :destroy

  validates :last_name, :first_name, :billing_address, :state, :zip, :card_name,
            :credit_card_number, :card_expiration, :card_cvv, :total_price, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :card_expiration, format: {
    with: %r{\A(0[1-9]|1[0-2])/\d{2}\z},
    message: :invalid_card_expiration_format
  }

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

  private

  def generate_next_promotion_code
    user.promotion_codes.create!(
      code: SecureRandom.alphanumeric(7).upcase,
      discount_amount: rand(100..1000),
      used: false
    )
  end
end
