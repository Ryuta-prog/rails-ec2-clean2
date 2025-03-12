# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAIL_FROM'].to_s.strip
  layout 'mailer'
end
