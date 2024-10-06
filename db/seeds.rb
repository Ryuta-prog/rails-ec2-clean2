# frozen_string_literal: true

require 'faraday'

# 商品データの定義
items = [
  { name: '高菜おにぎり', description: '高菜をふんだんに使ったおにぎり', price: 200,
    image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_takana.png' },
  { name: '鮭おにぎり', description: '新鮮な鮭を使ったおにぎり', price: 300,
    image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_sake.png' },
  { name: 'たらこおにぎり', description: '風味豊かなタラコを使ったおにぎり', price: 300,
    image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_tarako.png' },
  { name: '梅おにぎり', description: 'さっぱりとした梅の酸味が楽しめるおにぎり', price: 200,
    image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_ume.png' },
  { name: '天むすおにぎり', description: '海老の天ぷらが入ったおにぎり', price: 500,
    image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_tenmusu.png' },
  { name: '焼きおにぎり', description: '香ばしい焼きおにぎり', price: 200,
    image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_yakionigiri.png' },
  { name: 'ゆかりおにぎり', description: 'ゆかりをまぶしたおにぎり', price: 200,
    image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_yukari.png' },
  { name: '赤飯おにぎり', description: 'もち米を使用した赤飯おにぎり', price: 250,
    image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_sekihan.png' },
  { name: 'シーチキンおにぎり', description: 'シーチキンを使用したおにぎり', price: 300,
    image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_seachicken.png' },
  { name: 'わかめおにぎり', description: 'わかめを使用したおにぎり', price: 200,
    image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_wakame.png' },
  { name: 'スパムおにぎり', description: 'スパムを使用したおにぎり', price: 400,
    image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/supamusubi.png' },
  { name: '台湾おにぎり', description: '本格的な台湾おにぎり', price: 400, image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/food_taiwan_onigiri_fantuan.png' }
]

# 既存データの削除
Product.delete_all

# データベースに保存
items.each do |item|
  product = Product.create!(name: item[:name], description: item[:description], price: item[:price])

  # 画像を取得する
  response = Faraday.get(item[:image_url])
  next unless response.success?

  # 一時ファイルを作成して画像を保存し、ActiveStorageに添付
  Tempfile.create(['product_image', '.png']) do |file|
    file.binmode
    file.write(response.body)
    file.rewind # ファイルの読み取り位置を先頭に戻す

    product.image.attach(
      io: file,
      filename: "product_#{product.id}.png",
      content_type: response.headers['content-type']
    )
  end
end
