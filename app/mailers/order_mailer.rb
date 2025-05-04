# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  default from: 'onigiriya@xs279744.xsrv.jp'

  def confirmation_email(order, new_promotion_code = nil)
    @order = order
    @new_promotion_code = process_promotion_code(new_promotion_code)
    send_mail_with_logging
  end

  private

  def process_promotion_code(new_promotion_code)
    return new_promotion_code unless new_promotion_code

    begin
      processed_code = convert_promotion_code(new_promotion_code)
      log_promotion_code_info(processed_code)
      processed_code
    rescue StandardError => e
      Rails.logger.error("プロモーションコード処理エラー: #{e.message}")
      nil
    end
  end

  def convert_promotion_code(code)
    if code.is_a?(Hash)
      # OpenStructの代わりにStructを使用
      Struct.new(*code.keys).new(*code.values)
    elsif code.is_a?(String)
      begin
        GlobalID::Locator.locate(code)
      rescue StandardError
        nil
      end
    else
      code
    end
  end

  def log_promotion_code_info(promotion_code)
    Rails.logger.info("送信準備: 注文ID #{@order.id}, プロモーションコード: #{promotion_code&.code}")
    Rails.logger.info("プロモーションコードオブジェクト詳細: #{promotion_code.inspect}")
  end

  def send_mail_with_logging
    mail(
      to: @order.email,
      subject: I18n.t('mailers.order_mailer.confirmation_email.subject')
    )
  rescue StandardError => e
    Rails.logger.error("メール送信エラー: #{e.message}")
  end
end
