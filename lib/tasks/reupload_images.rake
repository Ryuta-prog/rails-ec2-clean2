# frozen_string_literal: true

require 'net/http'

namespace :products do
  desc 'Re-upload product images from S3 URLs'
  task reupload_images: :environment do
    ProductImageReuploader.new.execute
  end
end

class ProductImageReuploader
  def execute
    clean_inconsistent_blobs
    reupload_all_product_images
    report_results
  end

  private

  def clean_inconsistent_blobs
    puts '既存の不整合なBlobを削除中...'
    ActiveStorage::Blob.find_each do |blob|
      unless blob.service.exist?(blob.key)
        puts "  削除: #{blob.key} (#{blob.filename})"
        blob.purge
      end
    end
  end

  def reupload_all_product_images
    puts '商品画像を再アップロード中...'
    Product.find_each do |product|
      image_url = image_mapping[product.name]
      next unless image_url

      reupload_single_product_image(product, image_url)
    end
  end

  def reupload_single_product_image(product, image_url)
    product.image.purge if product.image.attached?

    uri = URI.parse(image_url)
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      file = StringIO.new(response.body)
      product.image.attach(
        io: file,
        filename: "#{product.name.parameterize}.png",
        content_type: 'image/png'
      )
      puts "  成功: #{product.name} - 画像を添付しました"
    else
      puts "  エラー: #{product.name} - HTTPエラー: #{response.code}"
    end
  rescue StandardError => e # メソッド全体をrescueで囲む
    puts "  エラー: #{product.name} - 予期せぬエラー: #{e.message}"
  end

  def report_results
    puts '再アップロード完了'
    puts "成功: #{Product.with_attached_image.count}/#{Product.count} 商品に画像が添付されています"
  end

  def image_mapping
    result = {}
    result['高菜おにぎり'] = 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_takana.png'
    result['鮭おにぎり'] = 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_sake.png'
    result['たらこおにぎり'] = 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_tarako.png'
    result['梅おにぎり'] = 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_ume.png'
    result['天むすおにぎり'] = 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_tenmusu.png'
    result['焼きおにぎり'] = 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_yakionigiri.png'
    result['ゆかりおにぎり'] = 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_yukari.png'
    result['赤飯おにぎり'] = 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_sekihan.png'
    result['シーチキンおにぎり'] = 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_seachicken.png'
    result['わかめおにぎり'] = 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/onigiri_wakame.png'
    result['スパムおにぎり'] = 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/supamusubi.png'
    result['台湾おにぎり'] = 'https://rails-ec.s3.ap-northeast-1.amazonaws.com/food_taiwan_onigiri_fantuan.png'
    result
  end
end
