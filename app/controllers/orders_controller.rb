# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_order, only: [:create]

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    ActiveRecord::Base.transaction do
      apply_promotion_code if params[:promotion_code].present?

      if @order.save
        create_order_items
        send_confirmation_email
        clear_cart
        generate_next_promotion_code
        redirect_to root_path, notice: t('.purchase_success')
      else
        Rails.logger.error "Order errors: #{@order.errors.full_messages}"

        load_cart_data
        render 'carts/show', status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    handle_transaction_error(e)
  end

  def handle_transaction_error(exception)
    Rails.logger.error "Order Error: #{exception.message}"
    Rails.logger.error "Order Validation Errors: #{@order.errors.full_messages}" if @order&.errors&.any?
    Rails.logger.error exception.backtrace.join("\n") # スタックトレース詳細を記録
    load_cart_data
    flash.now[:alert] = t('.transaction_error')
    render 'carts/show', status: :unprocessable_entity
  end

  private

  def initialize_order
    @order = current_user.orders.new(order_params)
    @order.total_price = current_cart.total_price(0)
  end

  def apply_promotion_code
    code = params[:order][:promotion_code].upcase.strip
    promotion_code = PromotionCode.find_by(code: code, used: false)

    unless promotion_code
      flash.now[:alert] = t('.invalid_promotion')
      return
    end

    @order.promotion_code = promotion_code
    @order.total_price -= promotion_code.discount_amount
    promotion_code.update!(used: true)
    session[:applied_promotion_code_id] = promotion_code.id
  end

  def generate_next_promotion_code
    @new_promotion_code = current_user.promotion_codes.create!(
      code: SecureRandom.alphanumeric(7).upcase,
      discount_amount: rand(100..1000),
      used: false
    )
  end

  def load_cart_data
    @cart = current_cart
    discount_amount = PromotionCode.find_by(id: session[:applied_promotion_code_id])&.discount_amount.to_i
    @total_price = @cart.total_price(discount_amount)
  end

  def create_order_items
    current_cart.cart_items.each do |cart_item|
      @order.order_items.create!(
        product_id: cart_item.product.id,
        product_name: cart_item.product.name,
        price: cart_item.product.price,
        quantity: cart_item.quantity
      )
    end
  rescue StandardError => e
    Rails.logger.error "OrderItem creation failed: #{e.message}"
    raise e
  end

  def send_confirmation_email
    OrderMailer.confirmation_email(@order, @new_promotion_code).deliver_later
  end

  def clear_cart
    current_cart.destroy!
    session[:cart_id] = nil
    session.delete(:applied_promotion_code_id)
  end

  def order_params
    params.require(:order).permit(
      :last_name, :first_name, :email, :billing_address, :address2,
      :state, :zip, :card_name, :credit_card_number, :card_expiration,
      :card_cvv
    )
  end
end
