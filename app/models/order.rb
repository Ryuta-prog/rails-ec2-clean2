# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  include JpPrefecture
  jp_prefecture :state
end
