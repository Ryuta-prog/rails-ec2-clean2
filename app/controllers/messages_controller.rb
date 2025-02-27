# frozen_string_literal: true

class MessagesController < ApplicationController
  def index
    @message = Message.new
  end

  def confirm
    @message = Message.new(message_params)
    render :index unless @message.valid?
  end

  def create
    @message = Message.new(message_params)
    if params[:back]
      render :new
    elsif @message.save
      MessageMailer.received_email(@message).deliver_now
      redirect_to messages_path, notice: 'メッセージが正常に送信されました。'
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :content)
  end
end
