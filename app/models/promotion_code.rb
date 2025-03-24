# frozen_string_literal: true

class PromotionCode < ApplicationRecord
  has_one :order, dependent: :nullify
  validates :code, presence: true, uniqueness: true
end
