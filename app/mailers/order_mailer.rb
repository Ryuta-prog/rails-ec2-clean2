# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  default from: 'onigiriya@xs279744.xsrv.jp'

  def confirmation_email
    @order = params[:order]
    mail(
      to: @order.email,
      subject: t('order_mailer.confirmation_email.subject')
    )
  end
end
