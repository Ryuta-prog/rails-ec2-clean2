# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :initialize_cart
  helper_method :current_cart

  private

  def initialize_cart
    @cart = Cart.find_by(id: session[:cart_id])
    return unless @cart.nil?

    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def current_cart
    cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = cart.id
    cart
  end

  # CurrentCartモジュールからメソッドを移動
  def set_cart
    @cart = current_cart
  end
end
