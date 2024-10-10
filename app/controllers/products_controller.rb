# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    # 商品を８件表示する
    @products = Product.limit(8).order(:id)

    # 商品がなければ、フラッシュメッセージを表示
    flash.now[:notice] = t('products.no_products') if @products.empty?
  end

  def show
    # 選択された商品の詳細を表示
    @product = Product.find(params[:id])

    # 商品一覧で表示した８つの商品のIDを取得して除外
    displayed_product_ids = Product.limit(8).pluck(:id)

    # 関連商品を4件表示する
    @related_products = Product.where.not(id: displayed_product_ids).where.not(id: @product.id).limit(4).order(:id)
  end
end
