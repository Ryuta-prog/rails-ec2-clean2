# frozen_string_literal: true

class PromotionCode < ApplicationRecord
  has_one :order, dependent: :nullify
  belongs_to :user
  validates :code, presence: true, uniqueness: true

  # 未使用のプロモーションコードを取得するスコープ
  scope :unused, -> { where(used: false) }
end
