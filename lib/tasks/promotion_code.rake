# frozen_string_literal: true

namespace :promotion_code do
  # rake promotion_code:generate の説明文を I18n から引っ張ってくる
  desc I18n.t('promotion_code.tasks.generate.desc')
  task generate: :environment do
    generated = []

    # 生成と保存をトランザクションでラップ
    ActiveRecord::Base.transaction do
      10.times do
        code     = SecureRandom.alphanumeric(7).upcase
        discount = rand(100..1000)

        begin
          PromotionCode.create!(code: code, discount_amount: discount, used: false)
          generated << { code: code, discount: discount }
        rescue ActiveRecord::RecordInvalid => e
          # どのバリデーションに引っかかったか出力
          puts "バリデーションエラー: #{e.record.errors.full_messages.join(', ')}"
          raise
        end
      end
    end

    # 見出しを出力
    puts I18n.t('promotion_code.tasks.generate.header')
    # 各コード行を出力
    generated.each do |c|
      puts I18n.t('promotion_code.tasks.generate.row_format',
                  code: c[:code],
                  discount: c[:discount])
    end
  end
end
