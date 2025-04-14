# frozen_string_literal: true

require 'open-uri'

# 商品グループ1
def onigiri_items_group1
  [
    { name: '高菜おにぎり', description: '高菜をふんだんに使ったおにぎり', price: 2000,
      image_url: 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_takana.png' },
    { name: '鮭おにぎり', description: '新鮮な鮭を使ったおにぎり', price: 3000,
      image_url: 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_sake.png' },
    {
      name: 'たらこおにぎり',
      description: '風味豊かなタラコを使ったおにぎり',
      price: 3000,
      image_url: 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_tarako.png'
    }
  ]
end

# 商品グループ2
def onigiri_items_group2
  [
    { name: '梅おにぎり', description: 'さっぱりとした梅の酸味が楽しめるおにぎり', price: 2000,
      image_url: 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_ume.png' },
    { name: '天むすおにぎり', description: '海老の天ぷらが入ったおにぎり', price: 5000,
      image_url: 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_tenmusu.png' },
    {
      name: '焼きおにぎり',
      description: '香ばしい焼きおにぎり',
      price: 2000,
      image_url: 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_yakionigiri.png'
    }
  ]
end

# 商品グループ3
def onigiri_items_group3
  [
    { name: 'ゆかりおにぎり', description: 'ゆかりをまぶしたおにぎり', price: 2000,
      image_url: 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_yukari.png' },
    { name: '赤飯おにぎり', description: 'もち米を使用した赤飯おにぎり', price: 2500,
      image_url: 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_sekihan.png' },
    {
      name: 'シーチキンおにぎり',
      description: 'シーチキンを使用したおにぎり',
      price: 3000,
      image_url: 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_seachicken.png'
    }
  ]
end

# 商品グループ4
def onigiri_items_group4
  [
    { name: 'わかめおにぎり', description: 'わかめを使用したおにぎり', price: 2000,
      image_url: 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_wakame.png' },
    { name: 'スパムおにぎり', description: 'スパムを使用したおにぎり', price: 4000,
      image_url: 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/supamusubi.png' },
    {
      name: '台湾おにぎり',
      description: '本格的な台湾おにぎり',
      price: 4000,
      image_url: 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/food_taiwan_onigiri_fantuan.png'
    }
  ]
end

# 全商品データを統合
def create_items
  [
    *onigiri_items_group1,
    *onigiri_items_group2,
    *onigiri_items_group3,
    *onigiri_items_group4
  ]
end

# 商品画像を添付するメソッド
def attach_product_image(product, image_url)
  return if image_url.blank?

  begin
    file = URI.parse(image_url).open
    filename = File.basename(URI.parse(image_url).path)
    product.image.attach(
      io: file,
      filename: filename,
      content_type: 'image/png'
    )
    Rails.logger.info("Image attached successfully for #{product.name}")
  rescue OpenURI::HTTPError => e
    Rails.logger.error("Failed to attach image for #{product.name}: #{e.message}")
  rescue StandardError => e
    Rails.logger.error("Unexpected error attaching image for #{product.name}: #{e.message}")
  ensure
    file&.close if file.respond_to?(:close)
  end
end

# 商品データを作成するメソッド
def create_products
  create_items.each do |item|
    product = Product.create!(
      name: item[:name],
      description: item[:description],
      price: item[:price],
      published: true # 公開状態を設定
    )

    # 商品画像を添付
    attach_product_image(product, item[:image_url])
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error(
      "Validation failed for product #{item[:name]} " \
      "with errors #{e.record.errors.full_messages.join(', ')}"
    )
  rescue StandardError => e
    Rails.logger.error("Failed to create product #{item[:name]} due to error #{e.message}")
  end
end

# トランザクションで商品データ作成処理を実行
ActiveRecord::Base.transaction do
  create_products
rescue StandardError => e
  Rails.logger.error('Seed error occurred during transaction rollback. Error details:')
  Rails.logger.error(e.message)
end
