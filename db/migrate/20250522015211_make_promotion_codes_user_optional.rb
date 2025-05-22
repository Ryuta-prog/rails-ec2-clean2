# frozen_string_literal: true

class MakePromotionCodesUserOptional < ActiveRecord::Migration[7.0]
  def change
    change_column_null :promotion_codes, :user_id, true
  end
end
