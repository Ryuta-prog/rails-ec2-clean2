# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def confirmation_email
    @order = params[:order]
    mail(to: @order.email, subject: I18n.t('mailers.order_mailer.confirmation_email.subject'))
  end
end
