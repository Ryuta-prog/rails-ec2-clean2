# frozen_string_literal: true

class MessageMailer < ApplicationMailer
  default to: '<onigiriya@xs279744.xsrv.jp>'

  def received_email(message)
    @message = message
    mail(to: 'longtaishangcun@gmail.com', subject: t('mailers.message.new_message')) do |format|
      format.text
    end
  end
end
