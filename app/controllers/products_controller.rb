# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    # 全てのプロダクトを取得
    @products = Product.all
  
    # ページネーションを適用して、8つの新しいプロダクトをページごとに表示
    @products = Product.limit(8)
  
    # 商品がなければ、フラッシュメッセージを表示
    flash.now[:notice] = t('products.no_products') if @products.empty?
  end
  
  def show
    # 選択された商品の詳細を表示
    @product = Product.find(params[:id])

    # 関連商品を表示
    @related_products = Product.where(id: [1, 95, 96, 97]).limit(4)
  end
end
