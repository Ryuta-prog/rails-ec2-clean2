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

    # 一覧画面と同じクエリで商品を取得
    displayed_products = Product.includes(image_attachment: :blob)
                                .limit(8)
                                .order(:id)

    @related_products = Product.includes(image_attachment: :blob)
                               .where.not(id: displayed_products.pluck(:id))
                               .where.not(id: @product.id)
                               .limit(4)
                               .order(:id)
  end
end
