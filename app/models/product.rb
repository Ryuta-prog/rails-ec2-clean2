# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :image

  validates :name, presence: { message: I18n.t('activerecord.errors.models.product.attributes.name.blank') }
  validates :price, presence: { message: I18n.t('activerecord.errors.models.product.attributes.price.blank') },
                    numericality: {
                      greater_than_or_equal_to: 0,
                      message: I18n.t('activerecord.errors.models.product.attributes.price.invalid')
                    }
  validates :description,
            presence: { message: I18n.t('activerecord.errors.models.product.attributes.description.blank') }
end
