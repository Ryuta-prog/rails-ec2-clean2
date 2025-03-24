# frozen_string_literal: true

namespace :promotion_code do
  desc I18n.t('promotion_code.task.generate.desc')
  task generate: :environment do
    generated_codes = generate_unique_codes
    output_results(generated_codes)
  end

  private

  def generate_unique_codes
    ActiveRecord::Base.transaction do
      10.times.map do
        code = SecureRandom.alphanumeric(6).upcase + rand(0..9).to_s
        discount = rand(100..1000)
        PromotionCode.create!(code: code, discount_amount: discount)
        { code: code, discount: discount }
      end
    end
  end

  def output_results(codes)
    header = I18n.t('promotion_code.tasks.generate.header')
    formatted = codes.map do |c|
      I18n.t('promotion_code.tasks.generate.row_format', **c)
    end
    puts "#{header}:\n#{formatted.join("\n")}"
  end
end
