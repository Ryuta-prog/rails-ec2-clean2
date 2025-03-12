# frozen_string_literal: true

module Admin
  class ProductsController < Admin::BaseController
    # Basic認証の追加
    before_action :authenticate

    # 管理画面用の商品一覧
    def index
      # 商品一覧と関連する画像情報を事前にロード
      @products = Product.includes(image_attachment: :blob).all
    end

    # 商品の詳細ページ
    def show
      @product = Product.find(params[:id])
    end

    # 新規商品作成ページ
    def new
      @product = Product.new
    end

    # 商品編集ページ
    def edit
      @product = Product.find(params[:id])
    end

    # 商品の作成処理
    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to admin_products_path, notice: t('admin.products.created')
      else
        render :new
      end
    end

    # 商品の更新処理
    def update
      @product = Product.find(params[:id])
      if @product.update(product_params)
        redirect_to admin_products_path, notice: t('admin.products.updated')
      else
        render :edit
      end
    end

    # 商品の削除
    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to admin_products_path, notice: t('admin.products.destroyed')
    end

    private

    # Basic認証のメソッド
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == 'admin' && password == 'pw'
      end
    end

    # ストロングパラメーター
    def product_params
      params.require(:product).permit(:name, :price, :description, :image)
    end
  end
end
