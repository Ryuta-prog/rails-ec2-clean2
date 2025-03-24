# frozen_string_literal: true

class PromotionService
  def initialize(order, code)
    @order = order
    @code = code.to_s.strip.upcase
  end

  def apply
    return error_response(:invalid_code) if invalid_code?

    apply_promotion
  rescue ActiveRecord::RecordInvalid => e
    log_error(e)
    error_responce(:system_error)
  end

  private

  def inavalid_code?
    @code.balank? || @code.length != 7
  end

  def apply_promotion
    PromotionCode.transaction do
      code = PromotionCode.lock.find_by(code: @code, used: false)
      code ? process_valid_code(code) : error_response(:invalid_code)
    end
  end

  def process_valid_code(code)
    @order.update!(
      discount: code.discount_amount,
      promotion_code: code
    )
    code.update!(used: true)
    { success: true, discount: code.discount_amount }
  end

  def error_response(key)
    { success: false, error: I18n.t("promotion_service.errors.#{key}") }
  end

  def log_error(exception)
    Rails.logger.error "Promotion Error: #{exception.message}"
  end
end
