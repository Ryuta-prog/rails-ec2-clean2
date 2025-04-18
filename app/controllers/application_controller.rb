# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart
  before_action :configure_permitted_parameters, if: :devise_controller?
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

  # Deviseのストロングパラメータ設定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[last_name first_name email password password_confirmation]
    )
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[last_name first_name email password password_confirmation current_password]
    )
  end
end
