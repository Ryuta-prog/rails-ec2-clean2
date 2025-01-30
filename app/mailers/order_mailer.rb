# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def order_confirmation(order)
    @order = order
    mail(
      to: @order.user.email, subject: '【おにぎりや】ご注文ありがとうございます'
    )
  end
end
