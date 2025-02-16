# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  default from: 'longtaishangcun@gmail.com'

  def confirmation_email
    @order = params[:order]
    mail(
      to: @order.email,
      subject: '【おにぎりや】ご注文ありがとうございます'
    )
  end
end
