# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    # 公開状態の商品を8件表示し、画像情報を事前にロードすることでN+1問題を解決
    @products = Product.where(published: true)
                       .includes(image_attachment: :blob)
                       .limit(8)
                       .order(:id)

    # 商品がなければ、フラッシュメッセージを表示
    flash.now[:notice] = t('products.no_products') if @products.empty?

    # ログ出力: 商品データの数を確認
    Rails.logger.info("Products loaded: #{@products.count}")
  end

  def show
    @product = Product.find(params[:id])
    Rails.logger.info("Product loaded: #{@product.inspect}")

    # 関連商品として表示したい商品のIDを取得
    related_product_ids = Product.where(published: true)
                                 .order(id: :desc)
                                 .limit(4)
                                 .pluck(:id)

    @related_products = Product.includes(image_attachment: :blob)
                               .where(id: related_product_ids)
                               .where.not(id: @product.id) # 現在表示中の商品は除外
                               .limit(4)
                               .order(:id)
    Rails.logger.info("Related products count: #{@related_products.count}")

    # 関連商品が存在しない場合の処理
    flash.now[:alert] = t('products.no_related_products') if @related_products.empty?

    # ログ出力: 関連商品の数を確認
    Rails.logger.info("Related products loaded: #{@related_products.count}")
  end
end
