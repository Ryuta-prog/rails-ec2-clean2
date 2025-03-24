# frozen_string_literal: true

module CartsHelper
  def current_promotion_code(session_promotion_code_id)
    PromotionCode.find_by(id: session_promotion_code_id)
  end
end
