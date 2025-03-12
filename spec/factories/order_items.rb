# frozen_string_literal: true

FactoryBot.define do
  factory :order_item do
    product_name { 'MyString' }
    price { '9.99' }
    quantity { 1 }
    order { nil }
  end
end
