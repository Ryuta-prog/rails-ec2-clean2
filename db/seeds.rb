# frozen_string_literal: true

require 'open-uri'

def onigiri_items_group1
  [
    {
      name: '高菜おにぎり',
      description: '高菜をふんだんに使ったおにぎり',
      price: 200,
      image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_takana.png'
    },
    {
      name: '鮭おにぎり',
      description: '新鮮な鮭を使ったおにぎり',
      price: 300,
      image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_sake.png'
    },
    {
      name: 'たらこおにぎり',
      description: '風味豊かなタラコを使ったおにぎり',
      price: 300,
      image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_tarako.png'
    }
  ]
end

def onigiri_items_group2
  [
    {
      name: '梅おにぎり',
      description: 'さっぱりとした梅の酸味が楽しめるおにぎり',
      price: 200,
      image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_ume.png'
    },
    {
      name: '天むすおにぎり',
      description: '海老の天ぷらが入ったおにぎり',
      price: 500,
      image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_tenmusu.png'
    },
    {
      name: '焼きおにぎり',
      description: '香ばしい焼きおにぎり',
      price: 200,
      image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_yakionigiri.png'
    }
  ]
end

def onigiri_items_group3
  [
    {
      name: 'ゆかりおにぎり',
      description: 'ゆかりをまぶしたおにぎり',
      price: 200,
      image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_yukari.png'
    },
    {
      name: '赤飯おにぎり',
      description: 'もち米を使用した赤飯おにぎり',
      price: 250,
      image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_sekihan.png'
    },
    {
      name: 'シーチキンおにぎり',
      description: 'シーチキンを使用したおにぎり',
      price: 300,
      image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_seachicken.png'
    }
  ]
end

def onigiri_items_group4
  [
    {
      name: 'わかめおにぎり',
      description: 'わかめを使用したおにぎり',
      price: 200,
      image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/onigiri_wakame.png'
    },
    {
      name: 'スパムおにぎり',
      description: 'スパムを使用したおにぎり',
      price: 400,
      image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/supamusubi.png'
    },
    {
      name: '台湾おにぎり',
      description: '本格的な台湾おにぎり',
      price: 400,
      image_url: 'https://rails-ec.s3.ap-southeast-2.amazonaws.com/food_taiwan_onigiri_fantuan.png'
    }
  ]
end

def create_items
  [
    *onigiri_items_group1,
    *onigiri_items_group2,
    *onigiri_items_group3,
    *onigiri_items_group4
  ]
end

def attach_product_image(product, image_url)
  return if image_url.blank?

  begin
    file = URI.parse(image_url).open
    product.image.attach(
      io: file,
      filename: "#{product.name.parameterize}.png",
      content_type: 'image/png'
    )
  rescue OpenURI::HTTPError
    nil
  ensure
    file&.close
  end
end

def create_products
  CartItem.destroy_all
  Cart.destroy_all
  Product.destroy_all

  create_items.each do |item|
    product = Product.new(
      name: item[:name],
      description: item[:description],
      price: item[:price],
      published: true
    )

    attach_product_image(product, item[:image_url])
    product.save!
  end
end

ActiveRecord::Base.transaction do
  create_products
rescue StandardError
  raise ActiveRecord::Rollback
end
