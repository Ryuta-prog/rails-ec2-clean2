# frozen_string_literal: true

module Admin
  class ProductsController < BaseController
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
      ActiveRecord::Base.transaction do
        CartItem.where(product_id: @product.id).destroy_all
        @product.destroy!
      end
      redirect_to admin_products_path, status: :see_other, notice: t('admin.products.destroyed')
    rescue ActiveRecord::RecordNotDestroyed
      redirect_to admin_products_path, alert: t('admin.products.destroy_failed')
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
