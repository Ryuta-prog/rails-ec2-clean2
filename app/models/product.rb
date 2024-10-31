# frozen_string_literal: true

# app/models/product.rb
class Product < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true

  # セール中かどうかの判定
  def on_sale
    sale_price.present? && sale_price < original_price
  end

  # バリデーションを削除して画像の保存を確認する
  # validate :image_presence

  private

  def image_presence
    errors.add(:image, :blank) unless image.attached?
  end
end
