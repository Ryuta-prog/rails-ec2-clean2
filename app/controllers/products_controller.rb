# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    # 商品を８件表示し、画像情報を事前にロードすることでN＋1問題を解決
    @products = Product.includes(image_attachment: :blob).limit(8).order(:id)

    # 商品がなければ、フラッシュメッセージを表示
    flash.now[:notice] = t('products.no_products') if @products.empty?
  end

  def show
    @product = Product.find(params[:id])

    # 関連商品として表示したい商品のIDを取得
    # 例えば、IDの大きい順に4つの商品を取得する
    related_product_ids = Product.order(id: :desc).limit(4).pluck(:id)

    @related_products = Product.includes(image_attachment: :blob)
                               .where(id: related_product_ids)
                               .where.not(id: @product.id) # 現在表示中の商品は除外
                               .limit(4)
                               .order(:id)
  end
end
