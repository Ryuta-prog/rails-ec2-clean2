# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def confirmation_email(order)
    @order = order
    mail(
      to: @order.email,
      subject: '【おにぎりや】ご注文ありがとうございます'
    )
  end
end
