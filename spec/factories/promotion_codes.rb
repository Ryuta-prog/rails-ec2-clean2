# frozen_string_literal: true

FactoryBot.define do
  factory :promotion_code do
    code { 'MyString' }
    discount_amount { 1 }
    used { false }
  end
end
