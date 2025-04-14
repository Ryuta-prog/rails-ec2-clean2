# frozen_string_literal: true

class OrderMailerPreview < ActionMailer::Preview
  def confirmation_email
    order = Order.first # サンプルデータとして最初の注文を使用
    OrderMailer.confirmation_email(order)
  end
end
