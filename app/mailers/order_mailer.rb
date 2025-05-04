# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  default from: 'onigiriya@xs279744.xsrv.jp'

  def confirmation_email(order, new_promotion_code = nil)
    @order = order
    @new_promotion_code = new_promotion_code
    mail(
      to: @order.email,
      subject: I18n.t('mailers.order_mailer.confirmation_email.subject')
    )
    begin
      mail(
        to: @order.email,
        subject: t('mailers.order_mailer.confirmation_email.subject')
      )
    rescue StandardError => e
      Rails.logger.error("メール送信エラー: #{e.message}")
    end
  end
end
