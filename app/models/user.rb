# frozen_string_literal: true

class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :promotion_codes, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true
  validates :first_name, presence: true
end
