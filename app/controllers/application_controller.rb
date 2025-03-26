# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart
  helper_method :current_cart

  private

  def current_cart
    return @current_cart if defined?(@current_cart)

    @current_cart = Cart.includes(:cart_items).find_by(id: session[:cart_id]) if session[:cart_id]

    @current_cart ||= Cart.create!
    session[:cart_id] ||= @current_cart.id
    @current_cart
  end

  def set_cart
    @cart = current_cart
  end
end
