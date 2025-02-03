# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    user { nil }
    total { 1 }
    billing_address { 'MyString' }
    credit_card_number { 'MyString' }
  end
end
