# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def confirmation_email(order)
    @order = order
    mail(
      to: @order.email,
      subject: t('mailers.order_mailer.confirmation_email.subject')
    )
  end
end
