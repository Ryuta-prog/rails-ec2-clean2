# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :initialize_cart
  helper_method :set_cart

  private

  def current_cart
    cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = cart.id
    cart
  end

  def set_cart
    @cart = current_cart
  end
end
