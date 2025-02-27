# frozen_string_literal: true

class MessageMailer < ApplicationMailer
  def new_message(message)
    @message = message
    mail(to: 'longtaishangcun@gmail.com', subject: 'New Message')
  end
end
