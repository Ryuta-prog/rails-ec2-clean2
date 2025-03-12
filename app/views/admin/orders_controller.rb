# frozen_string_literal: true

module Admin
  class OrdersController < ApplicationController
    before_action :authenticate
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def index
      @orders = Order.order(created_at: :desc)
    end

    def show
      @order = Order.find(params[:id])
    end

    private

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == 'admin' && password == 'pw'
      end
    end

    def not_found
      redirect_to admin_orders_path, alert: t('admin.orders.not_found')
    end
  end
end
