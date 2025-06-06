# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart
  helper_method :current_cart

  private

  def current_cart
    @current_cart ||= Cart.find_by(id: session[:cart_id]) || Cart.create!.tap do |c|
      session[:cart_id] = c.id
    end
  end

  def set_cart
    @cart = current_cart
  end
end
