# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    before_action :set_product, only: %i[show edit update destroy]
    def index
      @products = Product.order(created_at: :desc)
    end

    def show
      return unless @product.nil?

      redirect_to admin_products_path, alert: t('admin.products.not_found')
    end

    def new
      @product = Product.new
    end

    def edit; end

    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to admin_products_path, notice: t('admin.products.created')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @product.update(product_params)
        redirect_to admin_products_path, notice: t('admin.products.updated')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to admin_products_path, status: :see_other, notice: t('admin.products.destroyed')
    end

    private

    def set_product
      @product = Product.find_by(id: params[:id])
      redirect_to admin_products_path, alert: t('admin.products.not_found') if @product.nil?
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :image)
    end
  end
end
