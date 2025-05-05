# frozen_string_literal: true

class PromotionCode < ApplicationRecord
  has_one :order, dependent: :nullify
  belongs_to :user

  validates :code, presence: true, uniqueness: true
  validates :discount_amount, numericality: { greater_than_or_equal_to: 100, less_than_or_equal_to: 1000 }

  # 未使用のプロモーションコードを取得するスコープ
  scope :unused, -> { where(used: false) }

  # プロモーションコードが使用可能かどうかを判定する業務的ロジック
  def usable?
    !used &&
      (valid_from.nil? || valid_from <= Time.current) &&
      (valid_until.nil? || valid_until >= Time.current)
  end
end
