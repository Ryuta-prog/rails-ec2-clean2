# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  include JpPrefecture
  jp_prefecture :state
  validates :zip, presence: true
  validates :state, presence: true
  validates :billing_address, presence: true
end
