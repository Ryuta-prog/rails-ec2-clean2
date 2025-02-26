# frozen_string_literal: true

class MessageMailer < ApplicationMailer
  default to: '<onigiriya@xs279744.xsrv.jp>'

  def received_email(message)
    @message = message
    mail(subject: 'おにぎりやよりメッセージが届きました') do |format|
      format.text
    end
  end
end
