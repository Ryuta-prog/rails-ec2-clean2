# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart
  helper_method :current_cart
  before_action :basic_auth

  private

  def current_cart
    cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = cart.id
    cart
  end

  def set_cart
    @cart = current_cart
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' && password == 'pw'
    end
  end
end
