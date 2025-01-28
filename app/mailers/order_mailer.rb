class OrderMailer < ApplicationMailer
  def order_confirmation(order)
    @order = order
    mail(to: @order.user.email, subject: '購入明細')
  end
end
